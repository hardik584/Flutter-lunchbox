Image.network(
                  "https://image.shutterstock.com/image-photo/mount-kilimanjaro-kenya-amboseli-national-260nw-472419487.jpg",
                  frameBuilder: (BuildContext context, Widget child, int frame,
                      bool wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      child: child,
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeOut,
                    );
                  },
                  // loadingBuilder: (BuildContext context, Widget child,
                  //     ImageChunkEvent loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       value: loadingProgress.expectedTotalBytes != null
                  //           ? loadingProgress.cumulativeBytesLoaded /
                  //               loadingProgress.expectedTotalBytes
                  //           : null,
                  //     ),
                  //   );
                  // },
                ),
                //plese use any one builder of them
