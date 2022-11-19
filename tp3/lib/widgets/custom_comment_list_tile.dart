//https://api.flutter.dev/flutter/material/ListTile-class.html
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomCommentListItem extends StatelessWidget {
  const CustomCommentListItem({
    super.key,
    required this.userName,
    required this.postedTime,
    required this.body,
  });

  final String userName;
  final String postedTime;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _CommentTile(
              username: userName,
              postedTime: postedTime,
              body: body,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    required this.username,
    required this.postedTime,
    required this.body,
  });

  final String username;
  final String postedTime;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            DateFormat.yMMMd().format(DateTime.parse(postedTime)),
            style: const TextStyle(fontSize: 9.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            body,
            style: const TextStyle(fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
