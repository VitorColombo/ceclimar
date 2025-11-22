import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/pages/evaluate_register.dart';
import 'package:tcc_ceclimar/pages/register_view.dart';

class RegisterItem extends StatelessWidget {
  final RegisterResponse register;
  final String route;
  final bool isLoading;
  final VoidCallback? onDeleted;

  const RegisterItem({
    super.key,
    required this.register,
    required this.route,
    required this.isLoading,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: isLoading
              ? null
              : () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => route == RegisterDetailPage.routeName
                        ? RegisterDetailPage(
                          register: register,
                          onDelete: onDeleted,
                        )
                        : EvaluateRegister(
                          register: register,
                        ),
                    ),
                  );
                  if (result == true && onDeleted != null) {
                    onDeleted!();
                  }
                },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.transparent),
              ),
              child: Skeletonizer(
                enabled: isLoading,
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    width: 70,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: register.registerImageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: register.registerImageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                            )
                          : const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                    ),
                  ),
                  title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              register.animal.popularName!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Baseline(
                            baseline: 14,
                            baselineType: TextBaseline.alphabetic,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: register.status == "Validado"
                                    ? const Color.fromARGB(255, 178, 227, 170)
                                    : register.status == "Enviado"
                                      ? const Color.fromARGB(255, 255, 242, 124)
                                      : Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(PhosphorIcons.mapPin(), color: Colors.black, size: 20),
                          const SizedBox(width: 6),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(register.city.isEmpty ? "Cidade não informada" : register.city,
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(PhosphorIcons.calendarBlank(), color: Colors.black, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat('dd/MM/yyyy').format(register.date),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}