// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/multi_select/constants.dart';
import 'package:DNL/common/widgets/multi_select/multi_search_selection.dart';

class NationalityChoose extends StatefulWidget {
  final List<String> nation;
  final Function onChange;
  const NationalityChoose({
    super.key,
    required this.nation,
    required this.onChange,
  });

  @override
  _NationalityChooseState createState() => _NationalityChooseState();
}

class _NationalityChooseState extends State<NationalityChoose>
    with AutomaticKeepAliveClientMixin<NationalityChoose> {
  @override
  bool get wantKeepAlive => true;
  List<String> selectedCountryNames = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedCountryNames = widget.nation;

    List<Country> selectedCountries = List<Country>.generate(
      selectedCountryNames.length,
      (index) => Country(
        name: selectedCountryNames[index],
        iso: selectedCountryNames[index].substring(0, 2),
      ),
    );

    List<String> unselectedCountryNames = countryNames
        .where((element) => !selectedCountryNames.contains(element))
        .toList();

    List<Country> unselectedCountries = List<Country>.generate(
      unselectedCountryNames.length,
      (index) => Country(
        name: unselectedCountryNames[index],
        iso: unselectedCountryNames[index].substring(0, 2),
      ),
    );

    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent),
          child: MultipleSearchSelection<Country>(
            showClearAllButton: false,
            onItemAdded: (c) {
              selectedCountryNames.add(c.name);
              unselectedCountryNames.remove(c.name);
              widget.onChange(selectedCountryNames);
            },
            onItemRemoved: (c) {
              selectedCountryNames.remove(c.name);
              unselectedCountryNames.add(c.name);
              widget.onChange(selectedCountryNames);
            },
            showClearSearchFieldButton: true,
            items: unselectedCountries,
            fieldToCheck: (c) {
              return c.name;
            },
            initialPickedItems: selectedCountries,
            maxCount: 2,
            itemBuilder: (country, index) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(country.name),
                  ),
                ),
              );
            },
            pickedItemBuilder: (country) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(country.name),
                ),
              );
            },
            sortShowedItems: true,
            sortPickedItems: true,
            caseSensitiveSearch: false,
            fuzzySearch: FuzzySearch.none,
            itemsVisibility: ShowedItemsVisibility.alwaysOn,
            showSelectAllButton: true,
            maximumShowItemsHeight: 416,
          ),
        ),
      ],
    );
  }
}
