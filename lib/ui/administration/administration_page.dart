import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/main.dart';
import 'package:oceanapp/model/currency/currency.dart';
import 'package:oceanapp/model/dto/date_filter.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/transfer/transfer_body.dart';
import 'package:oceanapp/ui/home/home_page.dart';
import 'package:oceanapp/widgets/transfer_item_widget.dart';
import '../../bloc/item/bloc.dart';
import '../../bloc/item/event.dart';
import '../../bloc/item/state.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/branch/branch.dart';
import '../../model/item/item.dart';
import '../../model/sales/sales.dart';
import '../../model/settings/device_settings.dart';
import '../../model/user/user.dart';
import '../../utils/misc.dart';
import '../../widgets/device_widget.dart';
import '../../widgets/sales_widget.dart';

List<DeviceSettings> devices = [];
List<User> users = [];
List<Branch> branches = [];

class AdministrationPage extends StatefulWidget {
  static const route = "/administaration_page";

  final VoidCallback onSaved;
  const AdministrationPage({required this.onSaved});

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemBloc>(
        create: (BuildContext context) =>
            ItemBloc()..add(ItemInitItemEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ItemBloc>(context);

    return BlocListener<ItemBloc, ItemState>(
        listener: (context, state) async {
          if (state is ItemInitItemState) {
            if (!bloc.isClosed) bloc.add(GetDevicesEvent());
          } else if (state is ErrorItemState)
            pushToast(state.error);
          else if (state is DeletedDeviceState) {
            if (state.result) {
              if (mounted) {
                setState(() {
                  devices.removeWhere((x) => x.deviceId == state.deviceId);
                });
              }
            }
          } else if (state is GotDevicesState) {
            if (mounted) {
              setState(() {
                devices = state.devices;
              });
            }
            bloc.add(GetUsersEvent());
          } else if (state is GotUsersState) {
            if (mounted) {
              setState(() {
                users = state.users;
              });
              bloc.add(GetBranchesEvent());
            }
          } else if (state is GotBranchesState) {
            if (mounted) {
              setState(() {
                branches = state.branches;
              });
            }
          } else if (state is SavedDevicesState) {
            if (mounted) {
              setState(() {
                if (state.result) {
                  if (devices.firstWhereOrNull(
                          (d) => d.deviceId == deviceSettings.deviceId) !=
                      null)
                    deviceSettings = devices.firstWhere(
                        (d) => d.deviceId == deviceSettings.deviceId);
                  else
                    deviceSettings = DeviceSettings();

                  pushToast(translate("messages.settingsIsSaved"));

                  widget.onSaved();
                } else
                  pushToast(translate("messages.couldNotSaveSettings"));
              });
            }
          }
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, ItemState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final ItemBloc bloc;
  final ItemState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
            backgroundColor: backgroundColor1,
            toolbarHeight: SizeConfig().h(60),
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: [
                Padding(
                  child: CustomButton(
                    title: translate("buttons.save"),
                    onTap: () async {
                      widget.bloc.add(SaveDevicesEvent(devices));
                    },
                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                ),
              ],
            )),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(children: [
          (widget.state is LoadingItemState)
              ? Center(
                  child: CustomLoading(),
                )
              : Column(
                  children: [
                    Column(
                        children: devices
                            .map((x) => DeviceWidget(
                                  device: x,
                                  onChange: (x) {
                                    print("changed");
                                  },
                                  branches: branches,
                                  users: users,
                                  state: widget.state,
                                  onDeleteDevice: () {
                                    if (mounted) {
                                      setState(() {
                                        if (!widget.bloc.isClosed)
                                          widget.bloc.add(DeleteDeviceEvent(
                                              x.deviceId ?? ""));
                                      });
                                    }
                                  },
                                ))
                            .toList())
                  ],
                )
        ]))));
  }
}
