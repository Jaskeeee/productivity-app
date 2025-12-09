import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/icondata_serialization.dart';
import 'package:productivity_app/core/ui/widgets/text_count_up.dart';
import 'package:productivity_app/core/utils/math_utils.dart';
import 'package:productivity_app/features/home/domain/model/category_model.dart';
import 'package:productivity_app/features/home/presentation/components/sections/category/category_linear_indicator.dart';

class CateogriesCardList extends StatefulWidget {
  final List<CategoryModel> categories;
  const CateogriesCardList({
    super.key,
    required this.categories
  });

  @override
  State<CateogriesCardList> createState() => _CateogriesCardListState();
}

class _CateogriesCardListState extends State<CateogriesCardList> {
  @override
  Widget build(BuildContext context) {
    return CardStackWidget.builder(
      count: widget.categories.length,
      builder: (index) {
        final CategoryModel categoryModel = widget.categories[index];
        final Color  color = Color(categoryModel.color);
        final IconData iconData = deserializeIcon(categoryModel.icon)!.data;
        final double completion = completionValue(categoryModel.value.toDouble(), categoryModel.completed.toDouble());
        return CardModel(
          key: ValueKey(categoryModel.id),
          backgroundColor:color,
          radius: Radius.circular(20),
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height:200,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [        
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: DottedDecoration(
                        shape: Shape.circle,
                        strokeWidth: 2.0,
                        color: Theme.of(context).scaffoldBackgroundColor
                      ),
                      child: Icon(
                        iconData,
                        size: 25,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Text(
                        categoryModel.title,
                        style: TextStyle(
                          color:Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        maxLines:3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Spacer(),
                TextCountUp(
                  endValue:(completion*100), 
                  size: 40, 
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                SizedBox(width:40),
                CategoryLinearIndicator(
                  color: color, 
                  progress: completion,
                ),
              ],
            ),
          )          
        );
      },
    );
  }
}