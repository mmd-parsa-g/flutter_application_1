import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:provider/provider.dart';

abstract interface class SliderItem<T> {
  final T? value;
  final T? valuee;

  SliderItem({
    this.value,
    this.valuee,
  });

  Widget build(BuildContext context);
}

class SliderTextItem1<T> extends SliderItem<T> {
  final String text;
  final Color color;

  SliderTextItem1(
      {required super.value, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 14, color: color));
  }
}

class SliderTextItem2<T> extends SliderItem<T> {
  final String text;
  final Color color;

  SliderTextItem2(
      {required super.value, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: color,
      ),
    );
  }
}

class Mytext<T> extends SliderItem<T> {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final Color mycolor;

  Mytext({
    required super.value,
    required this.data,
    required this.mycolor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 14,
        color: mycolor,
      ),
    );
  }
}

class Mytext1<T> extends SliderItem<T> {
  // ignore: prefer_typing_uninitialized_variables
  final String data;
  final Color mycolor;

  Mytext1({required super.value, required this.data, required this.mycolor});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: 40, color: mycolor),
    );
  }
}

class Mybutton<T> extends SliderItem<T> {
  final IconData myicon;
  final Color mycolors;
  Mybutton(
      {super.valuee,
      required this.myicon,
      super.value,
      required this.mycolors});

  @override
  Widget build(BuildContext context) {
    return Container(color: mycolors, child: Icon(myicon));
  }
}

class Mydata1<T> extends StatefulWidget {
  const Mydata1({
    required this.groupValue,
    required this.children,
    required this.onChanged,
    super.key,
  });

  final List<SliderItem<T>> children;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  State<Mydata1> createState() => _Mydata1State();
}

class _Mydata1State extends State<Mydata1> {
  @override
  Widget build(BuildContext context) {
    return (Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.children.map(
            (c) => Padding(
              padding: const EdgeInsets.all(2),
              child: c.build(context),
            ),
          )
        ],
      ),
    ));
  }
}

class Mydata<T> extends StatefulWidget {
  const Mydata({
    required this.groupValue,
    required this.children,
    required this.onChanged,
    super.key,
  });

  final List<SliderItem<T>> children;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  State<Mydata> createState() => _MydataState();
}

class _MydataState extends State<Mydata> {
  @override
  Widget build(BuildContext context) {
    return (Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.children.map(
            (b) => Padding(
              padding: const EdgeInsets.all(5),
              child: b.build(context),
            ),
          )
        ],
      ),
    ));
  }
}

class Mytheme1<T> extends StatefulWidget {
  const Mytheme1(
      {super.key,
      required this.groupValue,
      required this.children,
      required this.onChanged});

  final List<SliderItem<T>> children;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  State<Mytheme1<T>> createState() => _Mytheme1State<T>();
}

class _Mytheme1State<T> extends State<Mytheme1<T>> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class Mybutton1<T> extends StatefulWidget {
  const Mybutton1(
      {super.key,
      required this.groupValue,
      required this.children,
      required this.onChanged});

  final List<SliderItem<T>> children;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  State<Mybutton1<T>> createState() => _Mybutton1State<T>();
}

class _Mybutton1State<T> extends State<Mybutton1<T>> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...widget.children.map(
            (b) => Padding(
              padding: EdgeInsets.all(3),
              child: Container(
                padding: EdgeInsets.all(2),
                child: InkWell(
                  onTap: () {
                    widget.onChanged.call(b.valuee as T);
                  },
                  child: b.build(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySlider<T> extends StatefulWidget {
  const MySlider({
    required this.groupValue,
    required this.children,
    required this.onChanged,
    super.key,
  });

  final List<SliderItem<T>> children;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  State<MySlider<T>> createState() => _MySliderState<T>();
}

class _MySliderState<T> extends State<MySlider<T>> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifeir, child) {
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.children.map(
                (a) => Padding(
                  padding: EdgeInsets.all(2),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: SizedBox(
                      key: UniqueKey(),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          splashFactory: InkRipple.splashFactory,
                          overlayColor: WidgetStateProperty.resolveWith(
                            (states) {
                              return states.contains(WidgetState.pressed)
                                  ? const Color.fromARGB(250, 252, 252, 252)
                                  : null;
                            },
                          ),
                          backgroundColor:
                              WidgetStateProperty.all(themeNotifeir.isDark
                                  ? a.value == widget.groupValue
                                      ? Colors.green.shade800
                                      : Colors.red.shade800
                                  : a.value == widget.groupValue
                                      ? Colors.green.shade400
                                      : Colors.red.shade400),
                        ),
                        onPressed: () {
                          widget.onChanged.call(a.value as T);
                        },
                        child: a.build(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
