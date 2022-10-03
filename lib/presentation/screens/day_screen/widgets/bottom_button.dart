import 'package:calendar/common/app_colors.dart';
import 'package:calendar/presentation/bloc/day_screen_bloc/day_screen_bloc.dart';
import 'package:calendar/services/text/two_digit_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        showModalBottomSheet(
          barrierColor: AppColors.halfTransparent,
          enableDrag: false,
          isDismissible: false,
          backgroundColor: AppColors.white,
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          builder: (context) => _AddNew(date: date),
        );
      },
      icon: const Icon(
        Icons.add_task,
        color: AppColors.blue,
        size: 16,
      ),
      label: const Text(
        'Add new',
        style: TextStyle(
          color: AppColors.text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AddNew extends StatefulWidget {
  const _AddNew({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  State<_AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<_AddNew> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TwoDigitFormat format = TwoDigitFormat();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayScreenBloc, DayScreenState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.85,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          context.read<DayScreenBloc>().add(ClearInputsEvent());
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: AppColors.text,
                          size: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            initialValue: widget.date.substring(0, 10),
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    color: AppColors.white,
                                    child: ListView.separated(
                                      itemCount: 48,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(height: 5);
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return TextButton.icon(
                                          onPressed: () {
                                            context.read<DayScreenBloc>().add(
                                                  SelectTimeEvent(
                                                    time: (index % 2) == 0
                                                        ? '${format((index / 2).floor().toString())}:00'
                                                        : '${format((index / 2).floor().toString())}:30',
                                                  ),
                                                );

                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.timer_sharp,
                                            color: AppColors.blue,
                                          ),
                                          label: Text(
                                            (index % 2) == 0
                                                ? '${format((index / 2).floor().toString())}:00'
                                                : '${format((index / 2).floor().toString())}:30',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: AppColors.text,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            controller: state.textController.time,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'HH:MM*',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColors.text,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter a time';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: state.textController.name,
                        readOnly: false,
                        cursorColor: AppColors.black,
                        decoration: InputDecoration(
                          hintText: 'Name*',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter a name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: state.textController.description,
                        readOnly: false,
                        cursorColor: AppColors.black,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        context.read<DayScreenBloc>().add(
                              CreateTaskEvent(date: widget.date),
                            );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
