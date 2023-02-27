import 'package:fapp/model/project.dart';

// ignore: non_constant_identifier_names
final buisness_projects = [
  Project(
      image:
          'https://info.ehl.edu/hubfs/Blog-EHL-Insights/Blog-Header-EHL-Insights/strategic-management.jpeg',
      title: 'Business Analysis of Small and Medium Enterprises',
      author: 'John',
      year: '2019',
      description:
          'An analysis of the challenges faced by small and medium enterprises in the business world and possible solutions to these challenges.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf"),
  Project(
      image:
          'https://www.sgsc.edu/content/userfiles/images/business%20administration.jpg',
      title: 'Marketing Strategies for the Retail Industry',
      author: 'Emma',
      year: '2019',
      description:
          'An examination of the various marketing strategies used in the retail industry and their effectiveness in reaching and engaging with customers.',
      projectPdfLink:
          "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf"),
  Project(
    projectPdfLink:
        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSX6uhlT-5xzmomqyrmlbMEg3x6IYwGw99cd5jhCFI5NZ4ibZJZvAnU44kprZ_lbSWPyRo&usqp=CAU',
    title: 'Supply Chain Management in the Food Industry',
    author: 'David',
    year: '2019',
    description:
        'An analysis of the various components of the supply chain in the food industry and the importance of effective management for the success of the industry.',
  ),
];

final cs_projects = [
  Project(
    projectPdfLink:
        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    image: 'https://i.ytimg.com/vi/Gz_PsRRxrHM/maxresdefault.jpg',
    title: 'Machine Learning for Image Classification',
    author: 'Sarah',
    year: '2019',
    description:
        'An application of machine learning algorithms for image classification and its performance evaluation.',
  ),
  Project(
    image:
        'http://www.science4all.org/wp-content/uploads/2012/12/online-security.jpg',
    title: 'Cybersecurity Threat Detection using AI',
    author: 'Michael',
    year: '2019',
    description:
        'A study on the use of artificial intelligence for detecting cybersecurity threats and its effectiveness.',
    projectPdfLink:
        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
  ),
  Project(
    image:
        'https://www.augray.com/blog/wp-content/uploads/2017/01/Augmented-Reality-vs-Virtual-Reality-1.jpg',
    title: 'Augmented Reality Gaming Experience',
    author: 'Jessica',
    year: '2019',
    description:
        'An exploration of augmented reality technology and its implementation in creating an immersive gaming experience.',
    projectPdfLink:
        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
  ),
];

final mathematics_projects = [
  Project(
    image:
        'https://www.researchgate.net/publication/360527348/figure/fig5/AS:11431281098774598@1669086600198/Optimization-of-logistics-and-warehousing-supply-management-for-ITE.png',
    title: 'Optimization in Logistics Management',
    author: 'William',
    year: '2019',
    description:
        'A mathematical analysis of optimization techniques for logistics management and their application in the transportation industry.',
    projectPdfLink:
        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
  ),
  Project(
    projectPdfLink:
        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    image:
        'https://uploads.toptal.io/blog/image/126357/toptal-blog-image-1528750626227-3f9eae3904c9c6a1b43c2698eb3d4b77.png',
    title: 'Financial Risk Modeling using Monte Carlo Simulation',
    author: 'Karen',
    year: '2019',
    description:
        'An investigation of financial risk modeling using Monte Carlo simulation and its application in portfolio management.',
  ),
  Project(
    projectPdfLink:
        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    image:
        'http://www.science4all.org/wp-content/uploads/2012/12/online-security.jpg',
    title: 'Number Theory and Cryptography',
    author: 'Peter',
    year: '2019',
    description:
        'A study of number theory and its application in cryptography, focusing on the security of digital communications.',
  ),
];

class ProjectCaetgorie {
  //--- title Of City
  final String title;
  //-- image
  final String image;
  //--- description
  final String description;

  final List<Project> projects;

  ProjectCaetgorie(
      {required this.title,
      required this.description,
      required this.image,
      required this.projects});

  static List allProjectCaetgories() {
    var lstOfProjectCaetgorie = [];
    lstOfProjectCaetgorie.add(ProjectCaetgorie(
        title: "Computer Science",
        description:
            "Explore the cutting-edge world of computer science with this collection of projects from the previous academic year. Dive into a variety of topics including programming, algorithms, data structures, and more. These projects provide hands-on experience in developing and implementing computer systems, and give you the opportunity to apply your knowledge and skills to real-world problems. Whether you're a computer science major or simply looking to expand your understanding of the field, these projects are sure to challenge and inspire you.",
        image:
            "https://f.hubspotusercontent10.net/hubfs/6448316/cybersecurity-computer-science.jpg",
        projects: cs_projects));
    lstOfProjectCaetgorie.add(ProjectCaetgorie(
        title: "Business Administration",
        description:
            "Advance your knowledge in the business world with this comprehensive collection of past year's Business Administration projects. This project will give you an in-depth understanding of the key concepts and strategies used in the field of business, from management and finance to marketing and operations. Whether you're a student studying business or a professional looking to expand your knowledge, this project is sure to provide valuable insights and practical skills that you can apply to your own work. With a focus on real-world examples and case studies, this project is a great resource for anyone looking to succeed in the business world.",
        image: "https://wallpaperaccess.com/full/1104816.jpg",
        projects: buisness_projects));
    lstOfProjectCaetgorie.add(
      ProjectCaetgorie(
          title: "Mathematics",
          description:
              "Unlock the secrets of mathematics with this captivating project from the previous academic year. Dive deep into complex concepts and problem-solving techniques as you explore the fascinating world of numbers and equations. Whether you're a math enthusiast or just looking to improve your skills, this project is sure to challenge and inspire you. Enhance your understanding of mathematical principles and gain valuable experience in research and presentation with this comprehensive and engaging project.",
          image:
              "https://www.deccanherald.com/sites/dh/files/styles/article_detail/public/articleimages/2022/12/23/math-istock-1-1173920-1671799039.jpg",
          projects: mathematics_projects),
    );
    return lstOfProjectCaetgorie;
  }
}


// Text(_allCities[index].image)

