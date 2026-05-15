import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/place_detail_controller.dart';
import '../../../widgets/gradient_scaffold.dart';
  import '../../../modules/home/views/widgets/HallsAndWorkspaces.dart';
Widget _buildInfoItem(String label, IconData icon) {
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF001F3F),
        ),
      ),
      const SizedBox(width: 4),
      Icon(icon, color: Colors.blue, size: 18),
    ],
  );
}

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(180),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 62),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Color(0xFFD4DADD)),
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 2,
                            children: [
                              Icon(
                                Icons.star_border,
                                size: 16,
                                color: Color(0xFF70848F),
                              ),
                              Text(
                                'أترك تقييماً',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF70848F),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_left,
                                size: 16,
                                color: Color(0xFF70848F),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(

                          spacing: 1,
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns text to the right for Arabic
                            children: [
                              SizedBox(height: 20),
                              // Main Title
                              const Text(
                                "المحطة",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF001F3F), // Dark Navy Blue
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Subtitle Row (Location and Rating)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "كرادة خارج",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                     const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const Text(
                                    " 4.9 (+1000)",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    
                                  ),
                               
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Info Icons Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _buildInfoItem(
                                    "القاعات: 3",
                                    Icons.event_seat_outlined,
                                  ),
                                  const SizedBox(width: 15),
                                  _buildInfoItem(
                                    "الفعاليات: 3",
                                    Icons.local_activity_outlined,
                                  ),
                                ],
                              ),
                            ],

                          ),
                    
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFD4DADD)),
                            borderRadius: BorderRadius.circular(100),
                            image: const DecorationImage(
                              image: AssetImage('images/computing_thumb.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Container(
              width: double.infinity,
              alignment: Alignment.topRight,
             
                
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("عن المكان" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF021B3B)),
                  ),
                  SizedBox(height: 5),
                  Text("مرحبًا بك في المحطة ، الوجهة المثالية لاستضافة فعالياتك، اجتماعاتك، والعمل المشترك. استمتع بتجربة فريدة في أجواء مريحة وخدمات متكاملة تناسب جميع احتياجاتك." , style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF021B3B)),
                  ),
                  SizedBox(height: 30),
                  Text("أقسام المكان" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF021B3B)),
                  ),
                  
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}