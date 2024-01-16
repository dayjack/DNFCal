import 'package:dnf_cal/models/CustomColor.dart';
import 'package:flutter/material.dart';

class RegisterCharacterPage extends StatefulWidget {
  const RegisterCharacterPage({Key? key}) : super(key: key);

  @override
  State<RegisterCharacterPage> createState() => _RegisterCharacterPageState();
}

class _RegisterCharacterPageState extends State<RegisterCharacterPage> {
  bool isEditing = false;
  List<int> items = List.generate(20, (index) => index);

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void removeItem(int id) {
    setState(() {
      items.removeWhere((item) => item == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        SizedBox(
          height: statusBarHeight + 16,
        ),
        RegisterChracterEditBar(
          onEdit: toggleEditing,
          isEditing: isEditing,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(22.0),
            color: Colors.transparent,
            child: GridView(
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 18,
              ),
              children: items
                  .map(
                    (id) => CharacterProfile(
                      isEditing: isEditing,
                      onDelete: () => removeItem(id),
                      id: id,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterChracterEditBar extends StatelessWidget {
  final VoidCallback onEdit;
  final bool isEditing;
  const RegisterChracterEditBar(
      {Key? key, required this.onEdit, required this.isEditing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      height: 41,
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.square,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '모험단 이름',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'DNFForgedBlade',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          isEditing
              ? IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit_off,
                    color: Colors.white,
                  ))
              : IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class CharacterProfile extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onDelete;
  final int id;
  const CharacterProfile({
    Key? key,
    required this.isEditing,
    required this.onDelete,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/images/character_background.png'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          isEditing ? _DeleteRegisterCharacterButton(context) : SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  _GuildNameWidget(),
                  _FameWidget(),
                  _CharacterImageWidget(),
                  _CharacterNameWidget(),
                  _TotalItemLevelWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _DeleteRegisterCharacterButton(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('캐릭터 등록 해제'),
                  content: Text('캐릭터를 등록 해제 하시겠습니까?\n'
                      '등록 해제된 캐릭터는 언제든 캐릭터 검색 탭에서 다시 등록할 수 있습니다.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('취소')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                        child: Text('확인')),
                  ],
                );
              });
        },
        icon: Icon(
          Icons.delete_forever,
          color: Color(0xffE80D0D),
        ),
      ),
    );
  }

  Widget _GuildNameWidget() {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Text(
        '[길드 이름]',
        style: TextStyle(
          color: Colors.white,
          fontSize: 6,
          fontFamily: 'DNFForgedBlade',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _FameWidget() {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.square,
            size: 6,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            '명성 수치',
            style: TextStyle(
              color: CustomColor.epic(),
              fontSize: 6,
              fontFamily: 'DNFForgedBlade',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _CharacterImageWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dummy_character.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _CharacterNameWidget() {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        '캐릭터 이름',
        style: TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontFamily: 'DNFForgedBlade',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _TotalItemLevelWidget() {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      child: Text(
        '총합 템레벨',
        style: TextStyle(
          color: CustomColor.epic(),
          fontSize: 6,
          fontFamily: 'DNFForgedBlade',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
