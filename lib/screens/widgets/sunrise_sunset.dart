import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SunriseSunsetWidget extends StatelessWidget {
  const SunriseSunsetWidget({
    super.key,
    this.sunRise,
    this.sunSet,
  });

  final DateTime? sunRise;
  final DateTime? sunSet;
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Container(
      width: Width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/sunrise.png',
                  scale: 2,
                ),
                const SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sunrise',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        sunRise != null
                            ? DateFormat().add_jm().format(sunRise!)
                            : "N/A"
                        // Fallback to "N/A" or similar placeholder
                        // '06:34 AM'
                        ,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 2,
            ),
            const VerticalDivider(
              color: Colors.white70,
              thickness: 0.5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 45,
                  child: Image.asset(
                    'assets/images/12.png',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sunset',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        sunSet != null
                            ? DateFormat().add_jm().format(sunSet!)
                            : "N/A",
                        // Fallback to "N/A" or similar placeholder
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
