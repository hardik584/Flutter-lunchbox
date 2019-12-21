PinFieldAutoFill(
                    decoration: BoxLooseDecoration(
                        solidColor: AppColors.white,
                        strokeWidth: 3,
                        strokeColor: Colors.grey,
                        textStyle: AppStyle.mediumTextStyle()),
                    // currentCode: '123456', // prefill with a code
                    onCodeSubmitted: (String code) {
                      Navigator.pushNamed(context, Constants.otpCompleteRoute);
                    },
                    keyboardType: TextInputType.number,
                    onCodeChanged: (String code) {},
                    codeLength: 6),
                    
lib:    sms_autofill: ^1.1.1
        pin_input_text_field: ^2.1.0
                    
