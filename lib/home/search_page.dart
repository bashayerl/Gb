import 'package:flutter/material.dart';
import 'package:fapp/model/project.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Project> _projects = [
    Project(
      image: 'smart_traffic_light.jpg',
      title: 'Smart Traffic Light System using IoT',
      author: 'John Doe',
      year: '2021',
      description:
          'A smart traffic light system using IoT to improve traffic flow.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'voice_controlled_assistant.jpg',
      title: 'Voice Controlled Personal Assistant',
      author: 'Jane Doe',
      year: '2021',
      description:
          'A voice-controlled personal assistant for hands-free control of smart devices.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'autonomous_vehicle.jpg',
      title: 'Autonomous Vehicle Navigation System',
      author: 'John Smith',
      year: '2021',
      description:
          'An autonomous vehicle navigation system using computer vision and machine learning.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'smart_home_automation.jpg',
      title: 'Smart Home Automation using IoT',
      author: 'Jane Smith',
      year: '2021',
      description:
          'A smart home automation system using IoT to control lighting, temperature, and security.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'face_recognition.jpg',
      title: 'Face Recognition System',
      author: 'Michael Johnson',
      year: '2021',
      description:
          'A face recognition system for secure access control and identification.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'augmented_reality.jpg',
      title: 'Augmented Reality for Education',
      author: 'Sarah Johnson',
      year: '2021',
      description:
          'An augmented reality system for enhancing education and learning experiences.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'personalized_healthcare.jpg',
      title: 'Personalized Healthcare using AI',
      author: 'David Brown',
      year: '2021',
      description:
          'A personalized healthcare system using AI for personalized treatment plans and diagnoses.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'virtual_assistant.jpg',
      title: 'Virtual Customer Service Assistant',
      author: 'Emily Brown',
      year: '2021',
      description:
          'A virtual customer service assistant using NLP for efficient customer support.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'smart_grid.jpg',
      title: 'Smart Grid System',
      author: 'Michael Davis',
      year: '2021',
      description:
          'A smart grid system using IoT for efficient energy distribution and management.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'internet_of_drones.jpg',
      title: 'Internet of Drones for Delivery',
      author: 'Emily Davis',
      year: '2021',
      description:
          'An IoT-based system for delivery using drones for efficient and fast delivery.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    ),
    Project(
      image: 'chatbot.jpg',
      title: 'Chatbot for Customer Service',
      author: 'William Wilson',
      year: '2021',
      description:
          'A chatbot for customer service using NLP for efficient and 24/7 support.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    )
  ];

  List<Project> _filteredProjects = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProjects = _projects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by project title',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                ),
                onChanged: (value) {
                  setState(() {
                    _filteredProjects = _projects
                        .where((book) => book.title
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredProjects[index].title),
                  subtitle: Text(_filteredProjects[index].author),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
