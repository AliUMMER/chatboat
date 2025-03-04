import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(0xff36B8B8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Terms And Conditions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '''Effective Date: [Insert Date]

Welcome to ChatBoat! By accessing or using our chat application ("App"), you agree to comply with and be bound by the following Terms and Conditions ("Terms"). Please read them carefully before using the App.

1. Acceptance of Terms
By downloading, installing, or using ChatBoat, you acknowledge that you have read, understood, and agree to these Terms. If you do not agree to these Terms, please do not use the App.

2. Eligibility
You must be at least 13 years old to use ChatBoat. By using the App, you represent and warrant that you meet this requirement.

3. User Responsibilities
- Provide accurate and current information when creating an account.
- Maintain the confidentiality of your login credentials.
- You are responsible for all activities that occur under your account.

4. Prohibited Activities
You agree not to:
- Use the App for any unlawful purposes.
- Harass, abuse, or harm other users.
- Upload or distribute any malicious software.
- Impersonate another person or entity.

5. Privacy
Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and safeguard your information.

6. Intellectual Property
All content, trademarks, and data on ChatBoat are the property of ChatBoat or its licensors and are protected by copyright and intellectual property laws.

7. Termination
We reserve the right to suspend or terminate your access to the App at our discretion, without notice, for conduct that violates these Terms or is harmful to other users or third parties.

8. Limitation of Liability
ChatBoat is provided "as is" without warranties of any kind. We are not liable for any damages arising from your use of the App.

9. Modifications to Terms
We may modify these Terms at any time. Continued use of the App after changes indicates your acceptance of the new Terms.

10. Contact Us
If you have any questions about these Terms, please contact us at [Insert Contact Information].

By using ChatBoat, you agree to these Terms and Conditions.''',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
