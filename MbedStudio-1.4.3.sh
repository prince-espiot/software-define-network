#!/usr/bin/env bash
set -o errexit

get_absolute_path() {
  [[ "${1:0:1}" == "/" ]] && echo $1 || echo `pwd`/$1
}

log () {
  echo "$1"
  [[ -n "$OUTPUT_FILE" ]] && echo "$1" >> "$OUTPUT_FILE"
  return 0
}

if [ -n "$SUDO_USER" ]
then
  log "Please do not run with sudo"
  exit 1
fi

LICENSE="****** Mbed Studio IDE EULA, Arm Compiler 6 EULA and Arm Compiler 6
Supplementary Terms ******
By clicking Agree and Continue, You hereby:
    * Agree and consent to End User License Agreement for Mbed Studio IDE – see
      Annex 1 below.
    * Agree and consent to End User License Agreement for Arm Compiler 6 – see
      Annex 2 below.
    * Agree and consent to ST License Agreement – see Annex 3 below.

ANNEX 1
END USER LICENCE AGREEMENT FOR MBED STUDIO IDE
THIS END USER LICENCE AGREEMENT FOR MBED STUDIO IDE (“LICENSE”) IS A LEGALLY-
BINDING AGREEMENT FOR THE USE OF THE SOFTWARE ACCOMPANYING THIS LICENSE,
BETWEEN ARM LIMITED (“ARM”) AND EITHER A SINGLE INDIVIDUAL OR SINGLE LEGAL
ENTITY (“SIGNATORY ENTITY”) AS APPLICABLE, ON WHOSE BEHALF YOU ARE LEGALLY
AUTHORIZED TO SIGN. AS USED HEREIN “YOU” OR “YOUR”, SHALL MEAN SUCH SINGLE
INDIVIDUAL OR SINGLE ENTITY.  ARM IS ONLY WILLING TO LICENSE THE SOFTWARE TO
YOU ON CONDITION THAT YOU ACCEPT ALL OF THE TERMS IN THIS LICENSE. BY CLICKING
“I AGREE” OR BY INSTALLING OR OTHERWISE USING OR COPYING THE SOFTWARE YOU
EXPRESSLY AGREE TO BE BOUND BY ALL OF THE TERMS OF THIS LICENSE. IF YOU DO NOT
AGREE TO THE TERMS OF THIS LICENSE, YOU MAY NOT INSTALL, USE OR COPY THE
SOFTWARE.
1.        Definitions
1.1       “Affiliate” means any person, partnership, joint venture, corporation
or other form of enterprise, domestic or foreign, including but not limited to
subsidiaries, that directly or indirectly, control, are controlled by, or are
under common control with You.
1.2       “Feedback” shall mean all suggestions, comments, feedback, ideas, or
know-how (whether in oral or written form), relating to Software, provided by
You to Arm during the Term of this License.
1.3       “Intellectual Property” means any patents, patent rights, trademarks,
service marks, registered designs, topography or semiconductor mask work
rights, applications for any of the foregoing, copyright, unregistered design
right and any other similar protected rights in any country and to the extent
recognised by any relevant jurisdiction as intellectual property, trade
secrets, know-how and confidential information.
1.4       “Mbed OS” means the mbed operating system that is subject to the
terms of the Apache Licence 2.0 and any other open sources licences included in
the files.
1.5       “Software” means the software, firmware and data accompanying this
Licence, any printed, electronic or online documentation supplied with it, and
any updates Arm may make available to You under the terms of this Licence.
1.6       “Subsidiary” means any company the majority of whose voting shares is
now or hereafter owned or controlled, directly or indirectly, by a party
hereto. A company shall be a Subsidiary only for the period during which such
control exists.
1.7       “Term” means the term of this Licence as set out in Clause 7. 
1.8       “Third Party Software” means the software authored by a third party
as indicated in the relevant file or directory.
2.        License $license$ Restrictions
License grant
2.1       Subject to the terms and conditions herein, Arm hereby grants to You
for the Term, a non-exclusive, non-transferable, world-wide licence, to use and
copy the Software to develop software applications and libraries that run on
Mbed OS only.
Permitted users
2.2       The Software shall only be used by your employees, workers,
consultants, professional advisors, bona fide sub-contractors or other members
of your organisation (“Permitted Users”) provided you hereby agree to be
responsible for their acts and omissions, and provided always that such
Permitted Users: (i) are contractually obliged to comply with the terms of this
Licence, including those relating to confidentiality; (ii) use the Software
only for your benefit; (iii) agree to assign all their work product and any
rights they create therein in the supply of such work to you; and (iv) do not
supply the Software or any components thereof to any third party whatsoever.
Except as expressly provided in this Licence or as agreed in writing by Arm on
a case by case basis, you shall not allow any third party (including but not
limited to any subsidiary, parent or affiliated company) to use the Software.
Reverse Engineering
2.3       Your use of the Software shall specifically exclude the reverse
engineering, decompiling, disassembly, translation, adaptation, arrangement or
other alteration of any part of the Software except to the extent that the
activity is permitted by applicable law.
Copyright and reservation of rights
2.4       The Software is owned by Arm and/or its licensors and is protected by
copyright and other intellectual property rights, laws and international
treaties. The Software is licensed not sold. You acquire no rights to the
Software or any element thereof other than as expressly provided by this
Licence. You shall not remove from the Software any copyright notice or other
notice and shall ensure that any such notice is reproduced in any permitted
reproduction of the whole or any part of the Software.
Licence to ARM to Feedback
2.5       You hereby grant to Arm and its Subsidiaries, under all of Your and
Your Affiliates’ (as applicable) Intellectual Property, a perpetual,
irrevocable, royalty free, non-exclusive, worldwide licence to; (i) use,
reproduce, prepare derivative works of, publicly display, publicly perform and
distribute the Feedback; (ii) make, have made, use, offer to sell, sell,
import, or otherwise distribute the Feedback; (iii) design, have designed,
made, have made, use, import, sell, offer to sell, and otherwise distribute and
dispose of products that incorporate the Feedback; and (iv) sublicense
(together with the rights to further sublicense) the rights granted in this
Clause 2.5 subpart (i) to subpart (iii) to any third party.
2.6       Except as expressly licensed in Clause 2.5, Arm acquires no right,
title or interest in the Feedback or any Intellectual Property therein. Except
as expressly provided herein, in no event shall the licences granted in Clause
2.5 be construed as granting ARM expressly or by implication, estoppel or
otherwise, licences to any of Your technology other than the Feedback.
3.        Third Party Software
3.1       The Software may contain Third-Party Software which is subject to the
terms of the licenses accompanying or otherwise applicable to that Third-Party
Software. Unless otherwise expressly indicated, the terms of the Third Party
Software licenses apply to the Third Party Software independent of the terms of
this Licence.
The Third-Party Software is provided “AS IS” and Arm expressly disclaims all
representations, warranties, conditions or other terms, express or implied,
including without limitation the implied warranties of non-infringement,
satisfactory quality, and fitness for a particular purpose. You acknowledge and
agree that Arm shall have no liability to You from any claims resulting from
Your use of the Third Party Software.
3A.       Data Collection and Privacy
3A.1      The Software may include features that enable it to transmit certain
computer information over the internet to Arm’s and/or its service providers’
computer systems, for example Your computer’s internet protocol address,
operating system details, host ID, or usability data (including information
identifying the source of that data) . This information shall be used by Arm
only for the purpose of Arm protecting its legitimate interests, which may
include  monitoring Your compliance with the permitted uses and restrictions
set out in this License, enhancing future releases of the Software and helping
streamline and improve customer experience.
3A.2      Information collected by the Software will only be used for the
aforementioned purposes. Please refer to the Arm Privacy Policy https://
www.arm.com/company/policies/privacy for further information on how Arm
collects, uses and safeguards personal data (including but not limited to
personal data collected for the protection of Arm’s legitimate interests and
your rights to object to its collection).
3A.3      When_accepting_the_terms_of_this_License_Arm_may_request_Your_consent
to_be_contacted_by_Arm_for_user_research_purposes._This_may_include_contacting
You_for_feedback_on_Mbed_OS_products,_or_contacting_You_to_ask_for_Your
participation_in_usability_research,_which_may_take_the_form_of_face-to-face_or
remote_sessions_with_a_user_experience_(UX)_engineer,_or_online_surveys._You
can_notify_Arm_in_writing_to_withdraw_Your_consent_at_any_time.
4.        Support and maintenance
4.1       Arm is no under obligation to provide You with support and
maintenance, but it may do at its sole discretion. 
5.        Warranties
5.1       THE SOFTWARE PROVIDED UNDER THIS LICENSE IS PROVIDED AS IS AND ARM
MAKES no warranties express, implied or statutory, including, without
limitation, the implied warranties of merchantability, satisfactory quality,
non-infringement or fitness for a particular purpose UNDER THIS LICENSE.
5.2       You shall not knowingly give to Arm any Feedback that you have reason
to believe is subject to any patent, copyright or other Intellectual Property
claim or right of any third-party other than Your Affiliates.
5.3       You hereby represent and warrant that You have the power to cause all
Intellectual Property owned or controlled by You or Your Affiliates to be
licensed as set forth in this License, including but not limited to that
relating to Feedback.
6.        Limitation of Liability
6.1       IN NO EVENT SHALL EITHER PARTY BE LIABLE UNDER THIS LICENSE FOR ANY
INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES WHETHER SUCH DAMAGES ARE
ALLEGED AS A RESULT OF TORTIOUS CONDUCT OR BREACH OF CONTRACT OR OTHERWISE EVEN
IF THE OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. SUCH
DAMAGES SHALL INCLUDE BUT SHALL NOT BE LIMITED TO THE COST OF REMOVAL AND
REINSTALLATION OF GOODS, LOSS OF GOODWILL, LOSS OF PROFITS, LOSS OR USE OF
DATA, INTERRUPTION OF BUSINESS OR OTHER ECONOMIC LOSS.
6.2       NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED IN THIS LICENSE,
THE MAXIMUM LIABILITY OF ARM TO YOU IN AGGREGATE FOR ALL CLAIMS MADE AGAINST
ARM IN CONTRACT TORT OR OTHERWISE UNDER OR IN CONNECTION WITH THIS LICENSE
SHALL NOT EXCEED THE FEES PAID (IF ANY) BY YOU TO ARM UNDER THIS LICENSE.
6.3       Nothing in this Clause 6 shall operate to exclude liability for: (i)
death or personal injury resulting from either party’s negligence; or (ii)
fraud.
7.        Term and Termination
7.1       This Licence shall remain in force until terminated by you or by ARM.
Without prejudice to any of your other rights if you are in breach of any of
the terms and conditions of this Licence then ARM may terminate this Licence
immediately upon giving written notice to you. You may terminate this Licence
at any time. Upon termination of this Licence by you or by ARM, you shall stop
using the Software and Confidential Information and destroy all copies of the
Software and confidential information in your possession, together with all
documentation and related materials.
7.2       Upon expiry or termination of this License the provisions of Clauses
1, 2.5 – 2.6, 3A, 5, 6, 7, and 8 shall survive.
8.        General
8.1       You shall not assign or otherwise transfer this License or any of
Your rights and obligations hereunder whether in whole or in part without the
prior written consent of Arm.
8.2       Failure or delay by either party to enforce any provision of this
License shall not be deemed a waiver of future enforcement of that or any other
provision.
8.3       This License constitutes the entire agreement between the parties
with respect to the subject matter hereof, and supersedes and replaces all
prior or contemporaneous understandings or agreements, written or oral,
regarding the subject matter. No amendment to, or modification of, this License
shall be binding unless in writing and signed by a duly authorised
representative of both parties.
8.4       All notices which are required to be given hereunder shall be in
writing and shall be sent to the address of the recipient set out in the quote
or purchase order, as the case may be. Any such notice may be delivered
personally, by commercial overnight courier or facsimile transmission which
shall be followed by a hard copy and shall be deemed to have been served if by
hand when delivered, if by commercial overnight courier 48 hours after deposit
with such courier, and if by facsimile transmission when dispatched.
8.5       Neither party shall be liable for any failure or delay in its
performance under this License due to causes, including, but not limited to,
acts of God, acts of civil or military authority, fires, epidemics, floods,
earthquakes, riots, wars, sabotage, third party industrial disputes and
governments actions, which are beyond its reasonable control; provided that the
delayed party: (i) gives the other party written notice of such cause promptly,
and in any event within fourteen (14) days of discovery thereof; and (ii) uses
its reasonable efforts to correct such failure or delay in its performance. The
delayed party’s time for performance or cure under this Clause 8.5 shall be
extended for a period equal to the duration of the cause.
8.6       You and Arm are independent parties. Neither company nor their
employees, consultants, contractors or agents, are agents, employees or joint
venturers of the other party, nor do they have the authority to bind the other
party by contract or otherwise to any obligation. Neither party will represent
to the contrary, either expressly, implicitly, by appearance or otherwise.
8.7       The provisions contained in each clause and sub-clause of this
License shall be enforceable independently of each of the others and if a
provision of this License is, or becomes, illegal, invalid or deemed
unenforceable by any court or administrative body of competent jurisdiction it
shall not affect the legality, validity or enforceability of any other
provisions of this License. If any of these provisions is so held to be
illegal, invalid or unenforceable but would be legal, valid or enforceable if
some part of the provision were deleted, the provision in question will apply
with such modification as may be necessary to make it legal, valid or
enforceable.
8.8       The Software and Arm Confidential Information provided under this
Licence are subject to U.K., European Union, and U.S. export control laws,
including the U.S. Export Administration Act and its associated regulations
(hereafter collectively referred to as “Export Regulations”). You agree to
comply fully with all such Export Regulations and You agree that You shall not,
either directly or indirectly, export in breach of the Export Regulations, any
Software or Arm Confidential Information (i) to any country, company or person
subject to export restrictions or sanctions under the Export Regulations; or
(ii) for any prohibited end use, which at the time of export requires an export
license or other governmental approval, without first obtaining such license or
approval.
8.9       The Software provided under this License consist solely of commercial
items.  You shall be responsible for ensuring that any provision of the
Software to the US Government in accordance with the terms of this License are
provided with the rights and subject to restrictions described herein.
8.10      Except as expressly stated in this License, the Contracts (Rights of
Third Parties) Act 1999 and any legislation amending or replacing that Act
shall not apply in relation to this License or any License, arrangement,
understanding, liability or obligation arising under or in connection with this
License and nothing in this License shall confer on any third party the right
to enforce any provision of this License.
8.11      The validity, construction and performance of this License shall be
governed by the laws of England.
LES-PRE-21303 – v1.2
ANNEX 2
END USER LICENCE AGREEMENT FOR ARM COMPILER 6
END USER LICENSE AGREEMENT FOR ARM SOFTWARE DEVELOPMENT TOOLS
This end user license agreement (“License”) is a legal agreement between you (a
single individual), or the company or organisation (a single legal entity) that
you represent and have the legal authority to bind, and Arm relating to use of
the Arm Tools. Arm is only willing to license the Arm Tools on condition that
you accept all of the terms of this License. By clicking “I Agree” or by
installing or otherwise using the Arm Tools and/or any Update thereto (as
permitted by this License) you indicate that you agree to be bound by all of
the terms and conditions of this License. If you do not agree to the terms of
this License, Arm will NOT license the Arm Tools to you, you may not install or
use the Arm Tools or any part thereof, and you shall promptly return the Arm
Tools to Arm or to your supplier (if not Arm) and ask for a refund of the
license fee paid (if any).
NOTE - YOUR ATTENTION IS DRAWN TO THE FOLLOWING:
(A) The terms and conditions set out in this License shall apply to the supply
by Arm of Arm Tools for both commercial and non-commercial use. If you are in
receipt of a Non-Commercial Use License for the Arm Tools (each capitalised
term as defined below), or the Arm Tools or any component thereof are
identified or classified as such, or you are receiving a license for the Arm
Tools free of charge, then notwithstanding any of the other terms and
conditions of this License, your use of the Arm Tools shall be limited by the
restrictions of use set out in clause 2.2 of this License.
(B) PLEASE NOTE any terms and conditions of use set out in the order
documentation provided to you by Arm and the Software Information File(s) (as
defined below) applicable to the Arm Tools provided to you with (or included
within) either (i) the Arm Tools, and/or (ii) any Updates to the Arm Tools,
which limit, extend or otherwise vary the permitted uses and restrictions
applicable to the Arm Tools (“Special Conditions”). The Special Conditions form
part of and are incorporated into this License. In the event of any conflict or
inconsistency between the provisions set out in the main body of this License
and any of the Special Conditions, the provisions set out in the Special
Conditions shall prevail (in the order in which they are listed in this
paragraph).
(C) This License (and any documents incorporated by reference herein) is the
sole and exclusive agreement between you and Arm for the Arm Tools, and (except
as agreed in writing to the contrary) no other document, including (but not
limited to) your purchase order or any other document supplied by you, will
form part of this License.
DEFINITIONS
For the purposes of this License the following words and expressions shall have
the following meanings:
“Arm” means Arm Limited whose registered office is situated at 110 Fulbourn
Road, Cambridge CB1 9NJ, England and/or any member of Arm's group of companies.
“Arm Documentation” means any printed, electronic or online documentation
relating to Arm Software licensed to you by Arm under this License.
“Arm Software” means any and all software, firmware and data licensed to you by
Arm under this License.
“Arm Tools” means any and all Arm Software and/or Arm Documentation owned or
licensed by Arm, and any Updates to the Arm Software and/or Arm Documentation.
“Arm Tools Performance Data” means any results, benchmarking data or other
information relating to or connected with your use or testing of the Arm Tools
which are indicative of their performance, efficacy, reliability or quality.
“Fees” means any fee(s) payable by you for the provision by Arm to you of the
Arm Tools and associated support and maintenance services, and any other fees
payable by you in accordance with this License that are agreed by the parties
from time to time.
“License Key” means an electronic license key issued to you by Arm which
enables you to use and run one or more Licensed Seat of an Arm Tool or a
component thereof in accordance with the terms of this License.
“Licensed Seats” means any and all Seats of the Arm Tools (including, if
applicable, Updates) that you are licensed to run and use concurrently under
the terms of this License, in the types and quantities specified in the order
documentation provided to you by Arm, as well as any additional or replacement
Seats of the Arm Tools that Arm agrees to provide to you from time to time
during the License Term.
“License Term” means the term set out in the order documentation provided to
you by Arm during which you shall be entitled to access and use the Arm Tools.
“Non-Commercial Use License” means an evaluation, preview, beta, pre-release,
pilot, academic, educational or community use only license.
“Permitted Users” means your employees, workers, consultants, professional
advisors, bona fide sub-contractors and service providers that use the Arm
Tools in connection with the provision of work carried out for your benefit,
and/or, other members of your organisation or third party users who use the Arm
Tools with your express written permission on computers (physical or virtual)
owned or controlled by you.
“Redistributables” means the example code, library files, configuration files,
header files, and any other Arm Tools or components thereof owned by Arm (or
licensed by Arm and provided to you under Arm's terms and conditions) which you
are permitted to include within Your Software and redistribute or sub-license
within Your Software to third parties, the details of which (if applicable) are
set out in a file or folder (the “Redistributables File”) typically named
'redistributables' located within an Arm Tool (or components thereof).
“Seat” means a written or electronic authorisation to run a software component
subject to the terms and restrictions specified in that authorisation.
“Software Information File(s)” means Third Party Licenses Files,
Redistributables Files, and/or Supplementary Terms Files (as the context
requires).
“Special Conditions” is as defined above in Recital (B) of this License.
“Specified Project” means a single design and development activity undertaken
by you or your Permitted Users relating to Your Software or Your Hardware, the
details of which will be set out in the order documentation provided to you by
Arm.
“Supplementary Terms File” means a software file or folder typically named
'supplementary_terms' located within an Arm Tool (or components thereof) which
(if applicable) details any component-specific extensions, limitations or other
variations to the terms of this License.
“Territory” means, if applicable, the geographical area detailed in the order
documentation provided to you by Arm to which your use of the Arm Tools or any
part thereof is restricted.
“Third Party Licenses File” means a software file or folder typically named
'third_party_licenses' located within an Arm Tool (or components thereof) which
(if applicable) details any third party material included in the relevant Arm
Tool which is not licensed under the terms of this License, and a reference to
the applicable third party license terms and conditions.
“Update” means an update, patch, hotfix, bug fix, support release, modification
or limited functional enhancement (as applicable) to an Arm Tool or component
thereof, including but not limited to error corrections to any program or
associated documentation developed by or for Arm comprised in the Arm Tools,
which (i) Arm makes generally available to the market, and (ii) does not, in
Arm's opinion, constitute an Upgrade or a new product.
“Upgrade” means a new release of an existing Arm Tool which Arm makes generally
available to the market and which usually contains major functional
improvements.
“Your Hardware” means hardware manufactured or developed by you or on your
behalf, or hardware owned or licensed by you, which is supported by the Arm
Tools.
“Your Reports” means any written reports or other information relating to the
behavior or performance of Your Software or Your Hardware, in html, binary,
text or any other format (excluding for the avoidance of doubt, Arm Tools
Performance Data), generated by you from or using the Arm Tools and any
modifications thereto.
“Your Software” means any software owned or licensed by you (including, but not
limited to, applications, libraries and Arm API compliant plug-ins, but
excluding Arm Software) which is supported by (or developed by you using) the
Arm Tools.
1. LICENSE GRANT
1.1 Subject to your compliance with the terms and conditions of this License,
and payment by you of the Fees (if any), Arm hereby grants to you and your
Permitted Users during the License Term a non-exclusive, non-transferable
license to receive and use the Arm Tools, certain components thereof, or
optional functionality, in the Territory only on the Licensed Seats or for a
Specified Project (as applicable) for the permitted uses set out in this clause
1 and subject to the restrictions set out in clause 2 (as limited, extended or
otherwise varied by any terms, including product-specific permitted uses and
restrictions, set out in the Special Conditions). Except as expressly permitted
by this License, you and your Permitted Users shall NOT copy, modify, sub-
license, redistribute or otherwise use any component of the Arm Tools.
1.2 PERMITTED USE OF THE ARM TOOLS: Except as otherwise provided in this
License, use of the Arm Tools (or components thereof) is permitted for the
purpose of:
(a) building, developing, testing, debugging, analysing and optimising Your
Software or Your Hardware;
(b) generation of Your Reports, and use of Your Reports to develop, test,
debug, analyse and optimise Your Software or Your Hardware; and
(c) only as expressly provided in the relevant Redistributables File: (i)
incorporating, compiling and/or linking the files listed in that
Redistributables File into Your Software, provided that Your Software contains
substantial additional functionality; and (ii) subject to clause 2.1 below,
reproducing and redistributing the files (and permitting your customers and/or
your authorised distributors to reproduce and redistribute the files), only in
object code form (unless otherwise specified in the relevant Redistributables
Files), and only as part of Your Software. You agree that, except as expressly
provided to the contrary in the relevant Redistributables File, you may only
copy the Arm Tools (or any component thereof) to the extent that such copying
is incidental to the permitted uses set out in this clause 1.2, including
installation, backup and execution.
2. YOUR OBLIGATIONS AND RESTRICTIONS ON USE
2.1 OBLIGATIONS RELATING TO REDISTRIBUTION: Any redistribution as permitted by
this License is subject to any restrictions set out in the applicable Special
Conditions, and your compliance with the following:
(a) in cases where you are expressly permitted under this License (including
for the avoidance of doubt by inclusion of agreed wording in the order
documentation provided to you by Arm) to sub-license or redistribute any
component of the Arm Tools to your customers, authorised distributors or other
third parties, you are responsible for ensuring that such customers, authorised
distributors and third parties accept, and are contractually bound (by
agreement with you or directly with Arm) to comply with, the terms and
conditions of this License;
(b) Any use by you of Arm's or any of its licensors' names, logos or trademarks
to publicise or market any of Your Software containing (or developed or
generated using) Arm Tools is subject to you obtaining express written
permission from Arm;
(c) You warrant that you shall not make any representations or warranties on
behalf of Arm in respect of any of the Arm Tools or in respect of any other
software, reports or documentation developed or generated by you in accordance
with the license grants set out in this License;
(d) You must reproduce or preserve (as applicable) any copyright notices which
are included in or with any Arm Tools or components thereof; and
(e) Except as otherwise agreed by Arm (including for the avoidance of doubt by
inclusion of the relevant permission in a Supplementary Terms File), you may
not disclose or otherwise distribute any Arm Tools Performance Data. For the
avoidance of doubt, nothing in this sub-clause 2.1 (e) shall prevent you from
disclosing or otherwise distributing Your Reports.
2.2 NON-COMMERCIAL USE AND FREE OF CHARGE LICENSES: If you are in receipt of a
Non-Commercial Use License for the Arm Tools, or the Arm Tools or any component
thereof are identified or classified as such, and/or you are receiving the Arm
Tools free of charge, then notwithstanding any of the other terms and
conditions of this License, your use (which includes use by your Permitted
Users) of the Arm Tools is limited as follows:
(a) if you are receiving the Arm Tools free of charge:
    * (i) no support or maintenance shall be provided to you in respect of the
      Arm Tools;
    * (ii) the warranty set out in clause 7.1 of this License does not apply to
      you or your use of the Arm Tools, and Arm gives no other warranty
      whatsoever in relation to (and accepts no liability in connection with)
      the Arm Tools or your use (as permitted by this License) of them;
    * (iii) Arm may immediately terminate this License at any time for any
      reason by giving written notice to you;
    * (iv) except as otherwise expressly agreed in writing by Arm, you shall
      grant to Arm in full the license set out in clause 3.2 of this License;
      and/or
          o (b) if you are receiving a Non-Commercial Use License or version
            (as applicable) of the Arm Tools:
    * (i) you and your Permitted Users may use the Arm Tools for internal use
      only; and
    * (ii) you are not permitted to distribute or sub-license (A) any part of
      the Arm Tools, or (B) Your Software, Your Hardware, or Your Reports
      developed under this License using the Arm Tools. The Arm Tools shall be
      used only by you and your Permitted Users, and you shall not (except as
      otherwise authorised in writing by Arm) allow any other third party
      whatsoever to use the Arm Tools.
For the avoidance of doubt, if you are receiving a Non-Commercial Use License
and the license is provided to you free of charge, the restrictions in both
sub-clauses (a) and (b) above will apply to your use of the Arm Tools.
2.3 LICENSE TYPES: Depending on the type of license you have agreed to purchase
from Arm under this License (the details of which are set out in the order
documentation provided to you by Arm), your use of the Arm Tools shall be
limited to:
(a) use of each Licensed Seat (i) by one individual named Permitted User only
on a specified item of computer hardware ('named-user license'), OR (ii) by one
individual Permitted User at a time only on a specified item of computer
hardware ('node-locked license'), OR (iii) by one individual Permitted User at
a time on specified items of computer hardware ('floating license'). In respect
of 'node-locked licenses', each Licensed Seat may only be used for one
'process' at any one time. For the purpose of this sub-clause 2.3 (a), each
'process' is the execution of an instance of an Arm Tool; or
(b) use for a Specified Project.
2.4 PERMITTED USERS: You hereby agree to be responsible for the acts and
omissions of any and all Permitted Users, and shall ensure that such Permitted
Users (i) are contractually obliged to comply with the terms of this License,
including those relating to confidentiality; and (ii) do not supply the Arm
Tools or any components thereof to any third party whatsoever. Except as
expressly provided in this License or as agreed in writing by Arm on a case by
case basis, you shall not sub-license, redistribute, lease, rent or otherwise
allow any third party to use the Arm Tools or License Keys.
2.5 REVERSE ENGINEERING: Your use of the Arm Tools shall specifically exclude
the reverse engineering, decompiling, disassembly, translation, adaptation,
arrangement or other alteration of any part of the Arm Tools (except to the
extent that applicable law overrides this provision or any part hereof).
2.6 COPYRIGHT AND RESERVATION OF RIGHTS: The Arm Tools are owned by Arm and/or
its licensors and are protected by copyright and other intellectual property
rights, laws and international treaties. The Arm Tools are licensed not sold.
Except as expressly provided by this License, you acquire no rights to the Arm
Tools or any element thereof, or to any other Arm products or services. You
shall not remove from the Arm Tools any copyright notice or other notice and
shall ensure that any such notice is reproduced in any permitted reproduction
of the whole or any part of the Arm Tools.
2.7 TECHNICAL RESTRICTIONS IN THE ARM TOOLS: You must comply with any technical
restrictions in the Arm Tools and License Keys, including any restrictions that
restrict use to certain components of the Arm Tools or use only for certain
purposes. You shall not work around any such technical restrictions.
2.8 ARM DOCUMENTATION: You may use the Arm Documentation (if any) internally
only in conjunction with your use of the Arm Software to which it relates.
3. LICENSE OF FEEDBACK TO ARM
3.1 You may at your discretion deliver any suggestions, comments, feedback,
ideas, or know-how (whether in oral or written form) to Arm relating to or
connected with your use of the Arm Tools (“Feedback”). Notwithstanding the
foregoing, you shall not knowingly give to Arm any Feedback that you are aware
(or should reasonably be aware) is subject to any patent, copyright or other
intellectual property claim or right of any third party.
3.2 Except as expressly notified by you to Arm (in writing which may include
email) to the contrary, you hereby grant to Arm under your and your affiliates
(as applicable) intellectual property, a perpetual, irrevocable, royalty free,
non-exclusive, worldwide license to: (i) use, copy, modify, and create
derivative works of the Feedback; (ii) sell, supply or otherwise distribute the
whole or any part of the Feedback (and derivative works thereof) as part of any
Arm owned or licensed product(s) without obligation or restriction of any kind;
and (iii) sub-license to third parties the foregoing rights, including the
right to sub-license to further third parties. No right is granted by you to
Arm to sub-license your and your affiliates (as applicable) intellectual
property except to the extent that it is provided to Arm as Feedback and is
embodied in any Arm owned or licensed product(s). For the avoidance of doubt,
if, during the License Term, you provide notice to Arm revoking the license
granted under this clause 3.2, you acknowledge and agree that such revocation
shall not apply to Feedback delivered to Arm prior to the date of receipt of
the revocation notice, and that (notwithstanding the foregoing) Arm shall
continue to be permitted to use Feedback received after the date of receipt of
the revocation notice for internal purposes.
3.3 Except as expressly licensed to Arm in clause 3.2, you retain all right,
title and interest in and to the Feedback provided by you under this License.
4. DATA COLLECTION AND PRIVACY
4.1 The Arm Software may include features that enable it to transmit certain
computer information over the internet to Arm's and/or its service providers'
computer systems, for example your computer's internet protocol address,
computer hardware and operating system details, or the serial numbers of the
Arm Tools you have licensed. This information will not be shared with any third
parties, and shall be used by Arm only for the purpose of Arm protecting its
legitimate interests, which may include Arm verifying your right to use the Arm
Tools and monitoring your compliance with the permitted uses and restrictions
set out in this License.
4.2 Arm may also collect anonymous data, which, for the avoidance of doubt,
cannot be used to identify individual users of the Arm Tools. This information
may be used by Arm to help us understand and analyse what components or
features in the Arm Tools our end users are using in order to (i) maintain and
improve the quality of the Arm Tools and the end user experience, (ii) inform
end users of relevant new and improved products and services, and (iii) assist
end users to maximise the performance of, or solve user experience issues with,
the Arm Tools.
4.3 Information collected by the Arm Software will only be used for the
aforementioned purposes. Please refer to the Arm Privacy Policy https://
www.arm.com/company/policies/privacy for further information on how Arm
collects, uses and safeguards personal data (including but not limited to
personal data collected for the protection of Arm's legitimate interests and
your rights to object to its collection).
5. SUPPORT AND MAINTENANCE
5.1 Provision of reasonable support and maintenance is subject to payment by
you of all applicable Fees.
5.2 Any support provided by Arm in accordance with the above clause 5.1 shall
(i) be provided by telephone, email or such other format as is designated by
Arm, (ii) be prioritised at Arm's discretion, and (iii) not be used as a
substitute for training or as additional resource for your projects.
5.3 Maintenance will generally be provided in the form of Updates to the Arm
Tools. Arm shall be under no obligation to provide such maintenance in respect
of any modifications made by you (where permitted) to the Arm Tools. Updates do
not constitute additional Licensed Seats and may only be used by you if you
have an active Licensed Seat to run and use such Updates. Updates will
generally be provided to you as soon as reasonably practicable following the
date of general public release of the Update by Arm.
5.4 In cases where the Arm Tools were provided to you free of charge, you are
not entitled to any support or maintenance for the Arm Tools from Arm, but Arm
may, in its sole discretion, provide support to you. If you obtained the Arm
Tools from an Arm authorised distributor, reseller or other third party,
support and maintenance may be provided by either Arm or the third party as per
the terms of your contract for supply. Arm shall not be responsible for any
delay or failure in connection with any third party supplier providing support
or maintenance that it is obligated to provide to you. Please refer to the
'Support' area of https://www.arm.com for details of Arm's support services,
relevant contact details, and (if applicable) details of other authorised
support channels.
5.5 Arm's obligations under this clause 5 are limited to the provision of
support and maintenance to you, and Arm is under no obligation to provide any
support and maintenance to any third parties. You agree to provide all front
line support services to all third parties to whom you distribute any Arm
Tools, Your Reports, Your Software or Your Hardware, pursuant to and in
accordance with the terms of this License.
5.6 This License does not grant you any entitlement to receive (i) Upgrades,
(ii) Arm products other than those specified in your product documentation, or
(iii) any new products developed or introduced by Arm from time to time, nor to
receive any support or maintenance in respect of the same.
6. CONFIDENTIALITY
6.1 You acknowledge that the Arm Tools, License Keys, Arm Tools Performance
Data, and any and all other software, documentation or other information
licensed to you by Arm, or provided to you during discussions about or in
connection with the Arm Tools (including this License and information provided
during the provision by Arm of any support), contain trade secrets and
confidential information of Arm (“Confidential Information”).
6.2 You agree to maintain all such Confidential Information in confidence and
apply security measures (such measures to be no less stringent than the
measures which you apply (or should reasonably apply) to protect your own like
information, but not less than a reasonable degree of care) to prevent their
unauthorised disclosure and use.
6.3 Subject to any restrictions imposed by applicable law, the period of
confidentiality shall be five (5) years from the date of disclosure of the
Confidential Information. You agree that you shall not use any such information
other than in your normal use of the Arm Tools as permitted by this License.
7. LIMITED WARRANTIES
7.1 Subject to the restrictions in clause 2, for the period of ninety (90) days
from the date of receipt by you of the Arm Tools, Arm warrants to you that (i)
the media on which any Arm Software is provided shall be free from defects in
materials and workmanship under normal use; and (ii) the Arm Software will
perform substantially in accordance with the accompanying Arm Documentation (if
any). Arm's total liability and your exclusive remedy for breach of these
warranties shall be limited to Arm, at Arm's option (a) replacing the defective
Arm Software; or (b) using reasonable efforts to correct material, documented,
reproducible defects in the Arm Software and delivering such corrected Arm
Software to you; or (c) if you licensed the Arm Software directly from Arm,
refunding the price paid by you to Arm for that Arm Software. Any replacement
Arm Software will be warranted for the remainder of the original warranty
period or thirty (30) days from the date of replacement, whichever is longer.
7.2 The Arm Software described in any Arm Documentation is subject to
continuous development and improvement. All particulars of the Arm Software and
its use as described in the Arm Documentation are given by Arm in good faith.
Consequently, the information contained in the Arm Documentation is subject to
change without notice and is not warranted to be error free. If you discover
any errors in the Arm Documentation please report them to Arm in writing. Any
Arm Documentation provided to you that relates to specific industry quality and
functional safety standard compliance may assist you in applying to a competent
auditor for certification of Your Software or Your Hardware, but you
acknowledge and agree that on its own such Arm Documentation may not provide
sufficient evidence of, or be compatible with, the required safety compliance
standards.
7.3 Except as provided in clause 7.1 above, you agree that the Arm Tools are
licensed “as is”, and that Arm expressly disclaims all representations,
warranties, conditions or other terms, express or implied or statutory,
including without limitation the implied warranties of non-infringement,
satisfactory quality, and fitness for a particular purpose. You acknowledge
that it is your responsibility to satisfy yourself that the Arm Tools are fit
for the intended purpose and satisfy your requirements, including compatibility
with Your Hardware, and you expressly assume all liabilities and risks relating
to (i) any use of an Arm Tool which is inconsistent with its design or any
guidance provided to you in the applicable Arm Documentation, and/or (ii) any
use of an Arm Tool with Your Software or Your Hardware where such software or
hardware (as applicable) is not supported by or compatible with the relevant
Arm Tool.
7.4 You expressly assume all liabilities and risks relating to your use or
operation of Your Software and Your Hardware designed or modified using the Arm
Tools, including without limitation, Your software or Your Hardware designed or
intended for safety-critical applications. Should Your Software or Your
Hardware prove defective, you assume the entire cost of all necessary
servicing, repair or correction.
8. LIMITATION OF LIABILITY
8.1 To the maximum extent permitted by applicable law, in no event shall Arm be
liable for any indirect, special, incidental or consequential damages
(including loss of profits) arising out of the use of, or inability to use, the
Arm Tools, whether based on a claim under contract, tort or otherwise, even if
Arm was advised of the possibility of such damages.
8.2 Arm does not seek to limit or exclude liability for death or personal
injury arising from Arm's negligence or Arm's fraud. Arm acknowledges that
certain jurisdictions do not permit the exclusion or limitation of liability
for consequential or incidental damages, and in such cases the above limitation
relating to liability for consequential damages may not apply to you.
8.3 Notwithstanding anything to the contrary contained in this License, the
maximum liability of Arm to you in aggregate (in contract, tort or otherwise)
in relation to or in connection with the subject matter of this License shall
not exceed the greater of (i) the total sums paid by you to Arm (if any) for
this License, and (ii) $10.00 USD. The existence of more than one claim will
not enlarge or extend the limit.
9. THIRD PARTY MATERIAL
9.1 The Arm Tools may contain material owned or developed by third parties,
including but not limited to open source software, freeware and commercial
software (“Third Party Material”). Any Third Party Material is subject to the
terms and conditions of the applicable Third Party Material license(s) and is
not covered under the terms of this License. Details relating to such Third
Party Material shall either be presented to you at the time of installation or
shall be detailed in the Third Party Licenses File(s). Your use of such Third
Party Material is subject to your compliance with the applicable Third Party
Material license(s).
9.2 Arm hereby disclaims any and all warranties express or implied from any
third parties regarding, or otherwise connected with, any Third Party Material
included in the Arm Tools and any Third Party Material from which the Arm Tools
are derived, and/or your use of any or all of the Third Party Material in
connection with Your Software or Your Hardware, including (without limitation)
any warranties of satisfactory quality or fitness for a particular purpose.
9.3 No Third Party Material licensors shall have any liability for any direct,
indirect, incidental, special, exemplary, or consequential damages (including
without limitation lost profits) howsoever caused and whether made under
contract, tort or otherwise arising in any way out of your use or distribution
of the Third Party Material or the exercise of any rights granted under either
or both this License and the legal terms applicable to any Third Party
Material, even if advised in advance of the possibility of such damages.
10. GOVERNMENT REQUIREMENTS
10.1 To the extent that you are an agency, contractor or instrumentality of the
U.S. Government, you and we agree that:
(a) the Arm Tools are commercial computer software and commercial computer
software documentation, and that your rights therein are as specified in this
License, per FAR 12.212 and DFARS 227.7202-3, as applicable, or in the case of
NASA, subject to NSF 1852.22786. Arm acknowledges that, whilst commercial
computer software or commercial computer software documentation shall be
acquired under licenses customarily provided to the public, such licenses must
be consistent with U.S. Federal law and otherwise satisfy the U.S. Government's
needs (“U.S. Government Requirements”); and
(b) you may assign your rights under this License to the relevant US Government
Federal Department or the successor contractor designated by the US Government
Federal Department upon termination of your related prime contract with that US
Government Federal Department. If you exercise your rights under this clause
10.1(b), you acknowledge and agree that you shall remain liable to Arm in
respect of all your obligations under this License.
10.2 If there is any material inconsistency between (i) either a U.S.
Government Requirement or a requirement of another government with which Arm is
mandated by statute to comply and (ii) any provision of this License, the terms
of the relevant government requirement shall prevail and the provision in
question shall be deemed varied or deleted (as applicable) as required by the
terms of the relevant government requirement. For the avoidance of doubt, in
such circumstances, all other terms, conditions and provisions of this License
will continue to be valid to the fullest extent permitted by law in accordance
with the below clause 12.3.
11. TERM AND TERMINATION
11.1 Subject to clauses 11.2 and 11.3 below, this License shall remain in force
until terminated by you, by Arm or (in the case of a time limited license) by
expiry.
11.2 In the event of a party breaching of any of the terms and conditions of
this License, which if capable of remedy, has not been remedied by that party
within thirty (30) days of the date of breach, without prejudice to any of its
other rights under this License, the non-breaching party may terminate this
License immediately upon giving written notice to the breaching party. Upon
termination of this License by you or by Arm, or upon expiry, you shall (and
shall ensure that your Permitted Users shall) immediately (i) stop using the
Arm Tools (or any element thereof) and any Confidential Information and, (ii)
destroy all copies of the same in your possession or control, together with all
Arm Documentation and related materials.
11.3 Notwithstanding the foregoing, except where Arm has terminated this
License for your breach, your rights (if applicable) to distribute any of Your
Software or Your Hardware developed using the Arm Tools prior to termination or
expiry of this License shall (subject to your continued compliance with the
terms and conditions of this License) survive such termination or expiry.
12. GENERAL
12.1 This License is governed by English Law. Notwithstanding the foregoing, to
the extent that you are an agency, contractor or instrumentality of the U.S.
Government, disputes arising under or relating to this License shall be decided
under the U.S. federal law of government contracting, including without
limitation the Contract Disputes Act. Nothing in this License shall prevent you
from enforcing your intellectual property rights or seeking injunctive or other
equitable relief in any court of competent jurisdiction. The parties hereby
disclaim application of the United Nations Convention on Contracts for the
International Sale of Goods and the Uniform Computer Information Transactions
Act.
12.2 Except where Arm agrees otherwise in (i) a written contract signed by you
and Arm, or (ii) a written contract provided by Arm and accepted by you, this
is the only agreement between you and Arm relating to the Arm Tools and it may
only be modified by written agreement between you and Arm. No terms and
conditions contained in any purchase order or other document issued by you, or
any advertising or other representation by you or any third party shall add to,
supersede or in any way vary the terms and conditions of this License. This
License (and any documents expressly incorporated into it by reference herein)
represents the entire agreement between you and Arm in relation to its subject
matter.
12.3 If any clause or sentence in this License is held by a court of law to be
illegal or unenforceable, the remaining provisions of this License shall not be
affected. Any failure by Arm to enforce any of the provisions of this License,
unless waived in writing, shall not constitute a waiver of Arm's rights to
enforce such provision or any other provision of this License in the future.
12.4 Subject to clause 10.1(b), neither this License or any rights granted to
you under it may be assigned, sub-licensed or otherwise transferred by you to
any third party without the prior written consent of Arm. An assignment shall
be deemed to include, without limitation (i) any transaction or series of
transactions whereby a third party acquires, directly or indirectly, the power
to control the management and policies of you, whether through the acquisition
of voting securities, by contract or otherwise; and (ii) the sale of more than
fifty percent (50%) of your assets whether in a single transaction or series of
transactions. Notwithstanding the foregoing, Arm may, in its discretion acting
reasonably, separately agree to authorise the re-host of a Licensed Seat (for
which additional charges may apply).
12.5 Subject to any applicable legal restrictions, including but not limited to
those relating to the security of classified information, at Arm's request, (i)
you agree to check your computers for installations of the Arm Tools, copies of
License Keys, contents of any license server log files, individual or
concurrent usage of Seats, and any other information requested by Arm relating
to Arm Tools installation, usage and License Key management, and, to provide
this information to Arm; and (ii) you agree that Arm may instruct appropriately
qualified independent auditors to perform such checks by prior appointment
during your normal business hours on reasonable notice. In respect of any
audit, Arm shall bear the auditors' costs for that audit unless it reveals
unlicensed usage, in which case you shall promptly reimburse Arm for all
reasonable costs and expenses, including professional fees, relating to such
audit. Any information which is disclosed to Arm or such auditors during
checking or audit shall be treated as your confidential information and shall
only be used by Arm for compliance and enforcement purposes.
12.6 The Arm Tools provided under this License are subject to U.S. export
control laws, including the U.S. Export Administration Act and its associated
regulations, and may be subject to export or import regulations in other
countries. You agree to comply fully with all laws and regulations of the
United States and other countries (“Export Laws”) to ensure that the Arm Tools
are not (i) exported, directly or indirectly, in violation of Export Laws,
either to any countries that are subject to U.S. export restrictions or to any
end user who has been prohibited from participating in the U.S export
transactions by any federal agency of the U.S. government; or (ii) intended to
be used for any purpose prohibited by Export Laws, including, without
limitation, nuclear, chemical, or biological weapons proliferation.
ANNEX 3
ST License Agreement
https://www.st.com/resource/en/license/SLA0047_STSW-LINK009.pdf"
DOMAIN=https://studio.mbed.com
ARCHIVE_PATH=/installers/latest/linux/MbedStudio.tar.gz
DEFAULT_OUPUT_FILE='mbed-studio.log'
VERBOSE=1

# options parsing
OPTIONS="yqfF:"
while getopts $OPTIONS OPTION
do
    case $OPTION in
        y  )    NOPROMPT=1;;
        q  )    unset VERBOSE;;
        f  )    OUTPUT_FILE=$(get_absolute_path $DEFAULT_OUPUT_FILE);;
        F  )    OUTPUT_FILE=$(get_absolute_path $OPTARG);;
        \? )    if (( (err & ERROPTS) != ERROPTS ))
                then
                    error $NOEXIT $ERROPTS "Unknown option."
                fi;;
        *  )    error $NOEXIT $ERROARG "Missing option argument.";;
    esac
done

shift $(($OPTIND - 1))

if [ -v $NOPROMPT ]
then
  # license agreement
  echo "In order to continue the installation process for Mbed Studio, please review the license agreement."
  read -p "Please, press ENTER to continue"

  echo "$LICENSE" | more

  echo "Do you accept the license terms? [yes|no]" 
  while true; do
      read -p ">>>>" yn
      case $yn in
          "yes" ) LICENSE_APPROVED=1; break;;
          "no" ) echo "The license agreement wasn't approved, aborting installation."; exit;;
          * ) echo "Please answer yes or no.";;
      esac
  done
fi

[[ -n $LICENSE_APPROVED && -n $VERBOSE ]] && log "License terms agreed"

# move to script folder
cd "$(dirname "$0")"

[[ -n $VERBOSE ]] && log "Cleaning installation folders..."

rm MbedStudioTmp -rf
[[ -n $VERBOSE ]] && log "Installation folders cleaned"

mkdir MbedStudioTmp
cd MbedStudioTmp

# download the mbed studio archive
[[ -n $VERBOSE ]] && log "Downloading installation packages..."
ARCHIVE_URL=$DOMAIN$ARCHIVE_PATH
wget $ARCHIVE_URL -q

if ! [ -f MbedStudio.tar.gz ]
  then log "An error happened while downloading Mbed Studio"
  exit 1
else
  [[ -n $VERBOSE ]] && log "Installation packages downloaded"
fi

# extract the .tar.gz archive
[[ -n $VERBOSE ]] && log "Extracting installation packages..."
tar -xzf MbedStudio.tar.gz --overwrite
[[ -n $VERBOSE ]] && log "Installation packages extracted successfully"

# make the current user the owner of the files
[[ -n $VERBOSE ]] && log "Making binary files executable..."
PRIMARY_GROUP_ID="$(id -g "$USER")"
chown -R $USER:$PRIMARY_GROUP_ID MbedStudio.tar.gz MbedStudio

# make the script executable
chmod u+x MbedStudio/*.sh
[[ -n $VERBOSE ]] && log "Binary files made executable"

# uninstall mbed studio if already present
if [ -f $HOME/.local/bin/mbed-studio-uninstall.sh ]; then
  [[ -n $VERBOSE ]] && log "Uninstalling old version of Mbed Studio..."
  $HOME/.local/bin/mbed-studio-uninstall.sh -u -q
  [[ -n $VERBOSE ]] && log "Old version of Mbed Studio uninstalled"
fi

# install mbed studio
INSTALLATION_PARAMS=()
[[ -z $VERBOSE ]] && INSTALLATION_PARAMS+=(-q)
[[ -n $OUTPUT_FILE ]] && INSTALLATION_PARAMS+=(-F) && INSTALLATION_PARAMS+=($OUTPUT_FILE)
./MbedStudio/install.sh "${INSTALLATION_PARAMS[@]}"

# cleanup
[[ -n $VERBOSE ]] && log "Cleaning up temporary files..."
cd ..
rm -rf MbedStudioTmp
[[ -n $VERBOSE ]] && log "Temporary files cleaned"

# check github.com ssh key
[[ -n $VERBOSE ]] && log "Checking github ssh key..."
if ! [ -f $HOME/.ssh/known_hosts ] || ! [ "$(ssh-keygen -F github.com)" ]
then
  if [ -n "$NOPROMPT" ]
  then
    GITHUB_APPROVED=1
  else
    echo "Do you want to accept the ssh key for host github.com? (This is necessary to connect Mbed Studio to github.com) [yes|no]"
    while true; do
      read -p ">>>>" yn
      case $yn in
          "yes" ) GITHUB_APPROVED=1; break;;
          "no" ) break;;
          * ) echo "Please answer yes or no.";;
      esac
  done
  fi
  if [ -n "$GITHUB_APPROVED" ]
  then
    [[ -n $VERBOSE ]] && log "Adding github ssh key..."
    ssh-keyscan -H github.com >> $HOME/.ssh/known_hosts 2> /dev/null
    [[ -n $VERBOSE ]] && log "Github ssh key added"
  fi
fi
[[ -n $VERBOSE ]] && log "Github ssh key check completed"

# checking linux version for libcurl4
[[ -n $VERBOSE ]] && log "Checking libcurl4..."
# get linux version
if ! [ -x "$(command -v dpkg)" ]; then
  log "Installation was successful."
  log "Please make sure that package 'libcurl4' is installed."
else
  # checking directly for libcurl4
  if ! [[ $(dpkg -l libcurl4-openssl-dev 2> /dev/null) ]]; then
    log "Installation was succesful but package 'libcurl4-openssl-dev' seems to be missing."
    log "To install it please run:"
    if [[ $(dpkg -l libcurl3 2> /dev/null) ]]; then
      log "cp /usr/lib/x86_64-linux-gnu/libcurl.so.3 /usr/lib/"
    fi
    log "apt-get install libcurl4 libcurl4-openssl-dev -y"
  fi
fi
[[ -n $VERBOSE ]] && log "libcurl4 checked"

exit 0
