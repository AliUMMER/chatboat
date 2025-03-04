import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
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
                      'Privacy policy',
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

Welcome to ChatBoat! Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our chat application ("App"). Please read this policy carefully to understand our views and practices regarding your personal data.

1. Information We Collect

Personal Information: When you register or use our App, we may collect personal information such as your name, email address, phone number, and any other information you voluntarily provide.

Usage Data: We automatically collect data about your interactions with the App, including IP addresses, browser type, device information, access times, and pages viewed.

Chat Data: Content of messages exchanged through ChatBoat may be collected and stored to enhance service performance and user experience.

2. How We Use Your Information

We use the collected information to:

Provide, operate, and maintain our App

Improve, personalize, and expand our services

Understand and analyze usage trends

Communicate with you, including sending updates and support messages

Ensure the security and integrity of our App

3. Sharing Your Information

We do not sell or rent your personal information. However, we may share your data with:

Service Providers: Third-party vendors who assist us in operating the App

Legal Obligations: Authorities when required to comply with legal obligations

Business Transfers: In case of a merger, sale, or asset transfer

4. Data Security

We implement security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.

5. Your Privacy Rights

You have the right to:

Access, update, or delete your personal information

Opt-out of receiving promotional communications

Request data portability

6. Children’s Privacy

ChatBoat is not intended for individuals under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have inadvertently received such data, we will delete it promptly.

7. Changes to This Privacy Policy

We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page. Continued use of the App after changes constitutes your acceptance of the revised policy.

8. Contact Us

If you have any questions or concerns about this Privacy Policy, please contact us at [Insert Contact Information]..''',
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
