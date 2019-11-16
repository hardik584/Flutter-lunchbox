 sublist = abcdf
                                .where((place) => place.properties.place
                                    .toLowerCase()
                                    .contains(searchtext.text.toLowerCase()))
                                .toList();
