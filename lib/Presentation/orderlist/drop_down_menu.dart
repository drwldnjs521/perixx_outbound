import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perixx_outbound/Domain/orderlist/order.dart';

final List<DropDownItem> menus = [
  const DropDownItem(
    'all',
    FaIcon(
      FontAwesomeIcons.arrowDown19,
      size: 20,
    ),
  ),
  DropDownItem(
    Status.processing.name,
    const FaIcon(
      FontAwesomeIcons.dolly,
      size: 20,
    ),
  ),
  DropDownItem(
    Status.scanned.name,
    const FaIcon(
      FontAwesomeIcons.qrcode,
      size: 20,
    ),
  ),
  DropDownItem(
    Status.shipped.name,
    const FaIcon(
      FontAwesomeIcons.truckFast,
      size: 20,
    ),
  ),
];

class DropDownItem {
  final String name;
  final FaIcon icon;

  const DropDownItem(this.name, this.icon);
}
