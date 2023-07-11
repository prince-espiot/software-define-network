
#include "GattServer.h"
#include "mbed.h"
#include <cstdio>
#include <iostream>
#include "ble/BLE.h"
//#include <BLE.h>

static EventQueue event_queue(16 * EVENTS_EVENT_SIZE);
static const char DEVICE_NAME[] = "BLEButton";
int _cancel_handle;

class GapButton : private mbed::NonCopyable<GapButton>, public ble::Gap::EventHandler
{

public:
    GapButton(BLE& ble,events::EventQueue& event_queue): 
    ble_(ble),event_queue_(event_queue),
    led_(LED1, 0),
    button_uuid_(0xAA00),
    button_(BUTTON1, PullUp), 
    adv_data_builder_(advBuffer){ }

    ~GapButton()
    {
        if (ble_.hasInitialized()) {     //cchecked
            ble_.shutdown();
        }
    }

    void run()
    {
        if (ble_.hasInitialized()) {
            printf("Ble instance already initialised.\r\n");
            return;
        } //checked
        /* handle gap events */
        ble_.gap().setEventHandler(this);
 
        ble_error_t error = ble_.init(this, &GapButton::on_init_complete);
 
        if (error) {
            printf("Error returned by BLE::init.\r\n");
            return;
        } //ck
 
        /* to show we're running we'll blink every 500ms */
        _cancel_handle = event_queue_.call_every(500ms, this, &GapButton::blink);

        /* this will not return until shutdown */
        event_queue_.dispatch_forever();
    } //cked
private:
    void on_init_complete(BLE::InitializationCompleteCallbackContext *event)
    {
        if (event->error) {
            printf("Error during the initialisation\r\n");
            return;
        }
 
        print_mac_address();
 
        button_.rise(Callback<void()>(this, &GapButton::button_pressed_callback));
 
        start_advertising();
    }//good

    void print_address(const ble::address_t &addr)
        {
    printf("%02x:%02x:%02x:%02x:%02x:%02x\r\n",
           addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
        }

     void print_mac_address()
    {
    /* Print out device MAC address to the console*/
    ble::own_address_type_t addr_type;
    ble::address_t address;
    BLE::Instance().gap().getAddress(addr_type, address);
    printf("DEVICE MAC ADDRESS: ");
    print_address(address);
    } //good

    void  start_advertising(){
            ble::AdvertisingParameters adv_parameters(
            ble::advertising_type_t::CONNECTABLE_UNDIRECTED,
            ble::adv_interval_t(ble::millisecond_t(1000))
        );

        adv_data_builder_.setFlags();
        adv_data_builder_.setName(DEVICE_NAME);
        adv_data_builder_.setLocalServiceList(mbed::make_Span(&button_uuid_, 1));
        

        adv_data_builder_.addData(ble::adv_data_type_t::MANUFACTURER_SPECIFIC_DATA,mbed::make_Span(&button_count_, 1));

        update_button_payload();
        

        ble_error_t error = ble_.gap().setAdvertisingParameters(
        ble::LEGACY_ADVERTISING_HANDLE,
        adv_parameters
                        );
     if (error) {
        printf("ble::BLE::errorToString(error) \n");
               return;
    }
    // then, the payload
    error = ble_.gap().setAdvertisingPayload(
        ble::LEGACY_ADVERTISING_HANDLE,
        adv_data_builder_.getAdvertisingData()
    );

    if (error) {
        
        printf("ble::BLE::errorToString(error) \n");
       return;
                    }

    /* Start advertising */
    error = ble_.gap().startAdvertising(ble::LEGACY_ADVERTISING_HANDLE);

    if (error) {
        printf("ble::BLE::errorToString(error) \n");
        return;
                 }
    }
//checked

    
    void update_button_payload()
    {
        /* The Service Data data type consists of a service UUID with the data associated with that service. */
       ble_error_t error = adv_data_builder_.replaceData(ble::adv_data_type_t::MANUFACTURER_SPECIFIC_DATA,
                          mbed::make_Span(&button_count_, 1));
       
        ble_error_t errorr = adv_data_builder_.setServiceData(
            button_uuid_,
            mbed::make_Span(&button_count_, 1));
 
        if (error != BLE_ERROR_NONE) {
            printf("Updating payload failed\n");

        }else {
            printf("button %d \n", button_count_);
        }
    }

    void button_pressed_callback()
    {
        ++button_count_;

        //printf("Button is suppose to grow\n");
        /* Calling BLE api in interrupt context may cause race conditions
           Using mbed-events to schedule calls to BLE api for safety */
        event_queue_.call(Callback<void()>(this, &GapButton::update_button_payload));
    }
    void blink(void)
    {
        led_ = !led_;
    }

    void keepOn(void)
    {
        led_ = 0;
    }

private:   

    void onConnectionComplete(const ble::ConnectionCompleteEvent &
	event) override{

	    if (event.getStatus() != BLE_ERROR_NONE) {
		    printf("Connection failed\n");
			    }else {
                led_ = event_queue_.cancel(_cancel_handle);
                event_queue_.call(Callback<void()>(this, &GapButton::keepOn));
                printf("keep LED ON\n");
             
            }
	}

    void onDisconnectionComplete (const ble::DisconnectionCompleteEvent &
	event) override{
        ble_.gap().startAdvertising(ble::LEGACY_ADVERTISING_HANDLE);
        
    }


private:
    BLE &ble_;
    events::EventQueue &event_queue_;
    uint8_t button_count_;
    InterruptIn button_;
    DigitalOut led_;
    ble::AdvertisingDataBuilder adv_data_builder_;
    uint8_t advBuffer[ble::LEGACY_ADVERTISING_MAX_SIZE];
    const UUID  button_uuid_;
   
};

void schedule_ble_events(BLE::OnEventsToProcessCallbackContext *context) {
    event_queue.call(Callback<void()>(&context->ble, &BLE::processEvents));
}

int main()
{
BLE &ble = BLE::Instance();
ble.onEventsToProcess(schedule_ble_events);
GapButton demo(ble, event_queue);
demo.run();
return 0;
}
