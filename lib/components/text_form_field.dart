import 'package:field_king/packages/config.dart';

typedef OnValidation = dynamic Function(String? text);

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool firstCapital;
  final bool disable;
  final bool readOnly;
  final String hint;
  final String? suffixIcon;
  final String? prefixIcon;
  final bool? isHasInVisibleBorder;
  final List<TextInputFormatter>? inputFormatter;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final Function(String?)? onSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final double? width;
  final double? height;
  final Color? textFieldColor;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final AutovalidateMode? autovalidateMode;
  final Function()? onPrefixIconTap, onSuffixIconTap;
  final bool? isPngSuffixIcon, isPngPrefixIcon;
  final EdgeInsets? suffixIconPadding;
  final Color? prefixIconColor, suffixIconColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? prefixIconPadding;
  final BorderRadius? borderRadius;
  final double? suffixIconSize;

  const InputField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.focusNode,
    this.obscureText = false,
    this.disable = false,
    this.firstCapital = false,
    this.hint = "",
    this.onChange,
    this.fillColor,
    this.inputFormatter,
    this.onSubmitted,
    this.onTap,
    this.isHasInVisibleBorder = false,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLine = 1,
    this.width,
    this.height,
    this.textFieldColor,
    this.hintStyle,
    this.borderColor,
    this.autovalidateMode,
    this.onPrefixIconTap,
    this.onSuffixIconTap,
    this.suffixIconPadding,
    this.isPngPrefixIcon,
    this.isPngSuffixIcon,
    this.suffixIconColor,
    this.prefixIconColor,
    this.textStyle,
    this.prefixIconPadding,
    this.borderRadius,
    this.suffixIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppColor.blackColor,
        ),
      ),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap ?? () {},
        textCapitalization:
            firstCapital ? TextCapitalization.words : TextCapitalization.none,
        cursorColor: AppColor.blackColor,
        cursorHeight: 25,
        cursorWidth: 1.5,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: false,
        obscureText: obscureText,
        maxLines: maxLine,
        inputFormatters: inputFormatter ?? [],
        style: textStyle ??
            const TextStyle().regular14.textColor(
                  // AppColor.optionalColor,
                  AppColor.blackColor,
                ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          prefixIcon: (prefixIcon ?? "").isEmpty
              ? null
              : GestureDetector(
                  onTap: onPrefixIconTap,
                  child: Padding(
                    padding: prefixIconPadding ??
                        const EdgeInsets.only(
                          left: 15,
                          right: 8,
                          top: 12,
                          bottom: 12,
                        ),
                    child: isPngPrefixIcon == true
                        ? Image.asset(
                            prefixIcon ?? "",
                            height: 16,
                            width: 16,
                            color: prefixIconColor ?? AppColor.blackColor,
                          )
                        : SvgPicture.asset(
                            prefixIcon ?? "",
                            height: 30,
                            width: 30,
                            colorFilter: ColorFilter.mode(
                              prefixIconColor ?? AppColor.blackColor,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
          isCollapsed: true,
          suffixIcon: (suffixIcon ?? "").isEmpty
              ? null
              : GestureDetector(
                  onTap: onSuffixIconTap,
                  child: Padding(
                    padding: suffixIconPadding ??
                        const EdgeInsets.only(
                          left: 8,
                          right: 12,
                          top: 12,
                          bottom: 12,
                        ),
                    child: isPngSuffixIcon == true
                        ? Image.asset(
                            suffixIcon ?? "",
                            height: suffixIconSize ?? 16,
                            width: suffixIconSize ?? 16,
                            color: suffixIconColor ??
                                // AppColor.optionalColor.withOpacity(0.50),
                                AppColor.blackColor.withOpacity(0.50),
                          )
                        : SvgPicture.asset(
                            suffixIcon ?? "",
                            height: suffixIconSize ?? 16,
                            width: suffixIconSize ?? 16,
                            colorFilter: ColorFilter.mode(
                              // suffixIconColor ?? AppColor.optionalColor.withOpacity(0.50),
                              suffixIconColor ??
                                  AppColor.blackColor.withOpacity(0.50),
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
          enabled: !disable,
          hintStyle: hintStyle ??
              const TextStyle().regular16.textColor(
                    AppColor.blackColor,
                  ),
          hintText: hint,
          filled: false,
          fillColor: fillColor ?? AppColor.whiteColor,
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7),
            borderSide: BorderSide(
              width: 1,
              color: AppColor.borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7),
            borderSide: BorderSide(
              width: 1,
              color: AppColor.borderColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7),
            borderSide: BorderSide(
              width: 1,
              color: AppColor.borderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7),
            borderSide: BorderSide(
              width: 1,
              color: AppColor.errorColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7),
            borderSide: BorderSide(
              width: 1.5,
              color: AppColor.errorColor,
            ),
          ),
          errorStyle: TextStyle().regular13.textColor(
                AppColor.errorColor,
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7),
            borderSide: BorderSide(
              width: 1,
              color: AppColor.borderColor,
            ),
          ),
        ),
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.visiblePassword,
        onChanged: (val) {
          if (onChange != null) {
            onChange!(val);
          }
        },
        onFieldSubmitted: onSubmitted,
        validator: (val) {
          if (validator != null) {
            return validator!(val);
          } else {
            return null;
          }
        },
      ),
    );
  }
}
