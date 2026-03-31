import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/model/model.dart';
import '../../../view_models/view_models.dart';
import '../../../widgets/widgets.dart';

class EstudiohhItemView extends StatelessWidget {
  final EstudiohhModel estudiohh;

  const EstudiohhItemView({
    super.key,
    required this.estudiohh,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<EstudiohhViewModel>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Año ${estudiohh.year}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    estudiohh.tipo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Link: ${estudiohh.url}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            )
            // 4. Botones + y - para modificar stock
         //   Column(
          //    children: [
            //    SizedBox(
          //        width: 40,
            //      height: 40,
            //      child: IconButton(
              //      icon: const Icon(
                //      Icons.add_circle_outline,
      //                color: Colors.green,
        //            ),
          //          onPressed: () {},
   //               ),
     //           ),
       //         SizedBox(
         //         width: 40,
           //       height: 40,
    //              child: IconButton(
      //              icon: Icon(
        //              Icons.remove_circle_outline,
          //            color: estudiohh.url.isNotEmpty ? Colors.red : Colors.grey,
      //              ),
        //            onPressed: estudiohh.url.isNotEmpty ? () {} : null,
          //        ),
            //    ),
      //        ],
          ],
        ),
      ),
    );
  }
}
