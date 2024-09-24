// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// class LanguagesScreen extends StatefulWidget {
//   const LanguagesScreen({super.key});
//
//   @override
//   State<LanguagesScreen> createState() => _LanguagesScreenState();
// }
//
// class _LanguagesScreenState extends State<LanguagesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             context.languages?.setting_language ?? '',
//             style: AppTextStyle().header04textStyle.bold,
//           ),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
//               child: Text(
//                 context.languages?.choose_language ?? '',
//                 style: AppTextStyle().titleTextStyle.bold,
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: LanguageSupport.values.length,
//                   itemBuilder: (context, index) {
//                     String assets = 'assets/icons/flags/flag_${LanguageSupport.values[index].code}.png';
//                     return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             border: Border.all(color: Colors.white),
//                             color: backgroundColor,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 7,
//                                 offset: const Offset(0, 4), // changes position of shadow
//                               ),
//                             ]),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(20),
//                             onTap: () {
//                               context.read<LanguageCubit>().changeLanguage(LanguageSupport.values[index]);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           assets,
//                                           width: 30,
//                                           height: 30,
//                                         ),
//                                         SizedBox(
//                                           width: 12.w,
//                                         ),
//                                         Text(
//                                           LanguageSupport.values[index].nativeLanguage,
//                                           style: AppTextStyle().titleTextStyle.bold,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   if (context.read<LanguageCubit>().state == LanguageSupport.values[index])
//                                     const Icon(
//                                       Icons.check,
//                                       color: Colors.green,
//                                     )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ));
//                   }),
//             ),
//           ],
//         ));
//   }
// }
