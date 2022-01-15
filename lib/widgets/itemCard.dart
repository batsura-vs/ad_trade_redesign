import 'package:ad_trade_redesing/home/skin_page/skin_page.dart';
import 'package:ad_trade_redesing/style/colors.dart';
import 'package:ad_trade_redesing/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final id, cost, name, color, d3, des, hash, user;

  const ItemCard(
      {Key? key,
      this.id,
      this.cost,
      this.name,
      this.d3,
      this.des,
      this.hash,
      this.color,
      this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => SkinPage(
              id,
              cost,
              name,
              color,
              d3,
              des,
              hash,
              user,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(3),
        height: MediaQuery.of(context).size.width / 3.2,
        width: MediaQuery.of(context).size.width / 3.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: outlineBorderColor),
          image: DecorationImage(
            image: NetworkImage(
                'https://community.cloudflare.steamstatic.com/economy/image/$id/330x192'),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(cost.toString(),
                    style: fontLoginText.copyWith(fontSize: 12))
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: fontLoginText.copyWith(
                        fontSize: 12, color: Color(int.parse('0xff$color'))),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
