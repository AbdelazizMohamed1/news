import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Widget defaultTextFormField({
  required TextEditingController controller,
  bool obscureText = false,
  required TextInputType textInputType,
  String? hintText,
  Widget? prefix,
  Widget? suffix,
  FormFieldValidator<String>? validate,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  void Function()? onTap,
  String? labelText,
  bool readOnly = false,
  FocusNode? focusNode,
}) =>
    TextFormField(
        focusNode: focusNode,
        readOnly: readOnly,
        onFieldSubmitted: onSubmit,
        onTap: onTap,
        onChanged: onChange,
        validator: validate,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: suffix,
          prefixIcon: prefix,
        ));

Widget buildArticleItem(article, context) {
  final String webUrl = article['url'];
  final Uri url = Uri.parse(webUrl);
  const String urlImage = 'urlToImage';
  NetworkImage image;
  if (article[urlImage] == null) {
    image = const NetworkImage(
      'https://static.vecteezy.com/system/resources/thumbnails/003/586/230/small/no-photo-sign-sticker-with-text-inscription-on-isolated-background-free-vector.jpg',
    );
  } else {
    image = NetworkImage('${article[urlImage]}');
  }
  return InkWell(
     onTap: () async {
       if (!await launchUrl(url)) {
         throw Exception('Could not launch $url');
       }
     },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(image: image, fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text('${article['publishedAt']}',
                      style: Theme.of(context).textTheme.bodyMedium
                      // TextStyle(
                      //   color: Colors.grey,
                      // ),
                      ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget defaultMaterialButton({
  required VoidCallback? onPressed,
  required String text,
  double width = double.infinity,
  Color? color = Colors.deepOrange,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: color,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text),
        height: 50.0,
      ),
    );




