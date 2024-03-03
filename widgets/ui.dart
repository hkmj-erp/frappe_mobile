import 'package:flutter/material.dart';
import '../extensions/extensions.dart';

class ReusableTextField extends StatelessWidget {
  final String text;
  final String? initialValue;
  final IconData icon;
  final bool isPasswordType;
  final TextInputType textInputType;
  final bool enabled;
  final bool readOnly;
  final AutovalidateMode autovalidateMode;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final double fontSize;
  final int? maxLines;
  final Widget? suffixIcon;
  const ReusableTextField(
      {super.key,
      required this.text,
      this.initialValue,
      required this.icon,
      this.isPasswordType = false,
      this.textInputType = TextInputType.text,
      this.enabled = true,
      this.readOnly = false,
      this.maxLines,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.onSaved,
      this.onTap,
      this.onChanged,
      this.validator,
      this.controller,
      this.fontSize = 20.0,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      maxLines: maxLines,
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      onSaved: onSaved ?? (v) {},
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged ?? (v) {},
      validator: validator ??
          (v) {
            return null;
          },
      // cursorColor: const Color.fromARGB(255, 215, 118, 118),
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          labelText: text,
          labelStyle: context.textTheme.labelLarge!.copyWith(color: context.colorScheme.secondary),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          // fillColor: colors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: context.colorScheme.primary, width: 10, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: context.colorScheme.secondary),
              borderRadius: BorderRadius.circular(5.0)),
          suffixIcon: suffixIcon),
      keyboardType: textInputType,
    );
  }
}

class ReusableDropDownField extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextInputType textInputType;
  final Function(String?)? onSaved;
  final List<DropdownMenuItem<String>>? items;
  final String selectedValue;
  final Function(String?) onChanged;
  final double fontSize;
  final bool isDense;
  final String? Function(String?)? validator;
  const ReusableDropDownField(
      {super.key,
      required this.text,
      required this.icon,
      this.textInputType = TextInputType.text,
      this.onSaved,
      this.validator,
      this.items,
      required this.selectedValue,
      required this.onChanged,
      this.fontSize = 20.0,
      this.isDense = false});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: DropdownButtonFormField<String>(
        items: items,
        isExpanded: true,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved ?? (v) {},
        isDense: isDense,
        value: selectedValue,
        style: TextStyle(fontSize: fontSize, color: context.colorScheme.onSecondaryContainer),
        dropdownColor: context.colorScheme.secondaryContainer,
        icon: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.arrow_drop_down_circle_rounded,
            size: 20,
            color: context.colorScheme.primary,
          ),
        ),
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: context.colorScheme.secondary,
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 50),
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 0, top: 4, right: 4),
            labelText: text,
            labelStyle: context.textTheme.labelLarge,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            // fillColor: Colors.white.withOpacity(.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(width: 10, style: BorderStyle.solid),
            ),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      ),
    );
  }
}

class ReusableButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color bgColor;
  final Color fgColor;

  const ReusableButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.fgColor = Colors.black,
      this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.onSecondaryContainer;
              }
              return fgColor;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.secondaryContainer;
              }
              return bgColor;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

class ReusableSmallButton extends StatelessWidget {
  final String? title;
  final IconData? iconData;
  final Function onTap;
  final Color? bgColor = const Color.fromARGB(255, 241, 249, 240);
  final Color? fgColor = const Color(0xFF5F071C);

  const ReusableSmallButton(
      {super.key, this.title, this.iconData, required this.onTap, Color? bgColor, Color? fgColor})
      : assert(!(title == null && iconData == null));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.onSecondaryContainer;
              }
              return fgColor;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.secondaryContainer;
              }
              return bgColor;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF5F071C), width: 1),
                borderRadius: BorderRadius.circular(10)))),
        child: Row(
          children: [
            iconData != null
                ? Icon(
                    iconData,
                    size: 30,
                  )
                : const SizedBox.shrink(),
            title != null
                ? Text(
                    title!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }
}

Container reusableIconButton({
  required BuildContext context,
  required IconData iconData,
  required Function onTap,
  Color? color,
}) {
  return Container(
    // width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: IconButton(
        color: color,
        onPressed: () {
          onTap();
        },
        icon: Icon(iconData)),
  );
}

resuableShortHeading({required String title, Color? bgColor, Color? fgColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: bgColor,
      // borderRadius: const BorderRadius.all(Radius.circular(5)),
    ),
    child: Text(
      title,
      style: TextStyle(color: fgColor, fontWeight: FontWeight.w300, fontSize: 15),
    ),
  );
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

class CustomIconButton extends StatelessWidget {
  final Size? size = const Size(50, 50);
  final Widget childIcon;
  final Color? fgColor = Colors.yellow;
  final Color? bgColor = Colors.black87;
  final Function()? onTap;
  const CustomIconButton({super.key, required this.onTap, required this.childIcon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: size,
            surfaceTintColor: Colors.white,
            padding: EdgeInsets.zero,
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            alignment: Alignment.center,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
        onPressed: onTap,
        child: childIcon);
  }
}

InputDecoration customInputDecoration(String hintText, Color color, Icon icon) {
  return InputDecoration(
      prefixIcon: icon,
      hintText: hintText,
      alignLabelWithHint: true,
      filled: true,
      fillColor: color,
      border: const OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(50.0))));
}
