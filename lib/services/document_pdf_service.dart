import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/document_model.dart';

class DocumentPdfService {
  static Future<Uint8List> generatePdf({
    required DocumentModel document,
    required Map<String, String> formData,
  }) async {
    final pdf = pw.Document();

    final fullName = _value(
      formData,
      ['full_name', 'name'],
    );

    final phone = _value(
      formData,
      ['phone'],
    );

    final email = _value(
      formData,
      ['email'],
    );

    final date = _value(
      formData,
      ['date', 'desired_date'],
      fallback: _formatDate(DateTime.now()),
    );

    final object = _value(
      formData,
      ['subject', 'object', 'request'],
      fallback: document.variant,
    );

    final recipient = _value(
      formData,
      ['recipient'],
      fallback: 'Madame, Monsieur',
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(45),

        // =========================
        // EN-TÊTE
        // =========================
        header: (context) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 20),
            child: pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'DOCS ADMINS',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      date,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Divider(),
              ],
            ),
          );
        },

        // =========================
        // PIED DE PAGE
        // =========================
        footer: (context) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(top: 15),
            child: pw.Row(
              mainAxisAlignment:
                  pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Document généré avec Docs Admins',
                  style: const pw.TextStyle(
                    fontSize: 8,
                  ),
                ),
                pw.Text(
                  'Page ${context.pageNumber} / ${context.pagesCount}',
                  style: const pw.TextStyle(
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          );
        },

        build: (context) {
          return [
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text(
                document.title.toUpperCase(),
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 25),

            pw.Text(
              'Informations du demandeur',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 8),

            _infoLine(
              'Nom complet',
              fullName,
            ),

            _infoLine(
              'Téléphone',
              phone,
            ),

            _infoLine(
              'Email',
              email,
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              recipient,
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              'Objet : $object',
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 20),

            ..._buildBody(
              document: document,
              formData: formData,
            ),

            pw.SizedBox(height: 25),

            // =========================
            // SIGNATURE
            // =========================
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(
                crossAxisAlignment:
                    pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'Signature',
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                  ),

                  pw.SizedBox(height: 45),

                  pw.Text(
                    fullName.isEmpty
                        ? 'Nom du demandeur'
                        : fullName,
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static List<pw.Widget> _buildBody({
    required DocumentModel document,
    required Map<String, String> formData,
  }) {
    final fullName = _value(
      formData,
      ['full_name'],
    );

    final school = _value(
      formData,
      ['school'],
    );

    final training = _value(
      formData,
      ['training'],
    );

    final company = _value(
      formData,
      ['company'],
    );

    final position = _value(
      formData,
      ['position'],
    );

    final domain = _value(
      formData,
      ['domain'],
    );

    final experience = _value(
      formData,
      ['experience'],
    );

    final skills = _value(
      formData,
      ['skills'],
    );

    final message = _value(
      formData,
      ['message'],
    );

    final request = _value(
      formData,
      ['request'],
    );

    final level = _value(
      formData,
      ['level'],
    );

    final academicYear = _value(
      formData,
      ['academic_year'],
    );

    final registrationNumber = _value(
      formData,
      ['registration_number'],
    );

    final startDate = _value(
      formData,
      ['start_date'],
    );

    final endDate = _value(
      formData,
      ['end_date'],
    );

    switch (document.id) {
      case 'stage_academique':
        return [
          _paragraph(
            'Madame, Monsieur,',
          ),
          _paragraph(
            'Actuellement étudiant(e) à '
            '${school.isEmpty ? "mon établissement" : school}, '
            'je suis à la recherche d’un stage académique '
            'dans le cadre de ma formation '
            '${training.isEmpty ? "" : "en $training"}.',
          ),
          _paragraph(
            'Ce stage me permettra de mettre en pratique '
            'les connaissances acquises au cours de ma formation '
            'et de développer davantage mes compétences professionnelles.',
          ),
          _paragraph(
            'Je souhaiterais ainsi avoir l’opportunité '
            'd’intégrer votre structure pour la période souhaitée.',
          ),
          if (startDate.isNotEmpty || endDate.isNotEmpty)
            _paragraph(
              'Période souhaitée : '
              '${startDate.isEmpty ? "à préciser" : startDate} '
              'au '
              '${endDate.isEmpty ? "à préciser" : endDate}.',
            ),
          _paragraph(
            'Je reste à votre disposition pour tout renseignement complémentaire.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'stage_professionnel':
        return [
          _paragraph('Madame, Monsieur,'),
          _paragraph(
            'Dans le cadre de mon parcours professionnel, '
            'je souhaite effectuer un stage au sein de votre structure '
            'afin de développer mon expérience '
            'et de mettre en pratique mes compétences.',
          ),
          _paragraph(
            'Mon intérêt porte particulièrement sur le domaine '
            '${domain.isEmpty ? "concerné" : domain}.',
          ),
          if (skills.isNotEmpty)
            _paragraph(
              'Compétences principales : $skills.',
            ),
          _paragraph(
            'Je serais honoré(e) de pouvoir rejoindre votre équipe '
            'durant la période souhaitée.',
          ),
          _paragraph(
            'Je reste disponible pour un entretien ou toute information complémentaire.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'motivation_offre':
        return [
          _paragraph('Madame, Monsieur,'),
          _paragraph(
            'Votre offre concernant le poste de '
            '${position.isEmpty ? "poste à pourvoir" : position} '
            'a retenu toute mon attention.',
          ),
          _paragraph(
            'Grâce à ma formation et à mon expérience '
            '${experience.isEmpty ? "dans ce domaine" : experience}, '
            'je souhaite mettre mes compétences au service de votre structure.',
          ),
          if (skills.isNotEmpty)
            _paragraph(
              'Je dispose notamment des compétences suivantes : $skills.',
            ),
          _paragraph(
            'Motivé(e), sérieux(se) et désireux(se) de progresser, '
            'je serais heureux(se) de pouvoir échanger avec vous lors d’un entretien.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'motivation_spontanee':
        return [
          _paragraph('Madame, Monsieur,'),
          _paragraph(
            'Je me permets de vous adresser ma candidature spontanée '
            'pour un poste correspondant à mon profil au sein de votre structure.',
          ),
          _paragraph(
            'Mon intérêt pour votre organisation ainsi que mon parcours '
            'me motivent particulièrement à proposer ma candidature.',
          ),
          if (domain.isNotEmpty)
            _paragraph(
              'Je souhaite notamment évoluer dans le domaine de $domain.',
            ),
          if (skills.isNotEmpty)
            _paragraph(
              'Mes principales compétences sont les suivantes : $skills.',
            ),
          _paragraph(
            'Je serais ravi(e) de pouvoir vous rencontrer afin de vous présenter '
            'plus précisément mon parcours et mes motivations.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'emploi_spontane':
        return [
          _paragraph('Madame, Monsieur,'),
          _paragraph(
            'Par la présente, je souhaite vous soumettre ma candidature '
            'pour un emploi au sein de votre structure.',
          ),
          _paragraph(
            'Mon parcours et mes compétences me permettent d’envisager '
            'une collaboration dans le domaine '
            '${domain.isEmpty ? "correspondant à mon profil" : domain}.',
          ),
          if (experience.isNotEmpty)
            _paragraph(
              'Mon expérience : $experience.',
            ),
          if (skills.isNotEmpty)
            _paragraph(
              'Compétences : $skills.',
            ),
          _paragraph(
            'Je reste disponible pour tout échange permettant '
            'de déterminer les possibilités de collaboration.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'emploi_offre':
        return [
          _paragraph('Madame, Monsieur,'),
          _paragraph(
            'Je souhaite vous adresser ma candidature en réponse à votre offre '
            'relative au poste de '
            '${position.isEmpty ? "poste à pourvoir" : position}.',
          ),
          _paragraph(
            'Mon parcours professionnel et mes compétences correspondent '
            'aux exigences du poste proposé.',
          ),
          if (experience.isNotEmpty)
            _paragraph(
              'Expérience : $experience.',
            ),
          if (skills.isNotEmpty)
            _paragraph(
              'Compétences : $skills.',
            ),
          _paragraph(
            'Je serais heureux(se) de pouvoir présenter plus en détail '
            'ma candidature lors d’un entretien.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'demande_administrative':
        return [
          _paragraph(
            'Je soussigné(e) '
            '${fullName.isEmpty ? "le demandeur" : fullName}, '
            'viens par la présente solliciter votre bienveillance '
            'concernant la demande suivante :',
          ),
          pw.SizedBox(height: 8),
          _paragraph(
            request.isEmpty
                ? 'Veuillez préciser ici l’objet de la demande.'
                : request,
          ),
          _paragraph(
            'Dans l’attente d’une suite favorable à ma demande, '
            'je vous prie d’agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'lettre_administrative':
        return [
          _paragraph('Madame, Monsieur,'),
          _paragraph(
            'Par la présente, je viens respectueusement auprès de votre autorité '
            'soumettre la demande suivante :',
          ),
          pw.SizedBox(height: 8),
          _paragraph(
            request.isEmpty
                ? 'Veuillez préciser ici votre demande.'
                : request,
          ),
          _paragraph(
            'Je vous remercie par avance de l’attention portée à ma demande.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];

      case 'attestation_scolarite':
        return [
          _paragraph(
            'Nous attestons par la présente que '
            '${fullName.isEmpty ? "l’intéressé(e)" : fullName} '
            'est régulièrement inscrit(e) au sein de '
            '${school.isEmpty ? "notre établissement" : school}.',
          ),
          if (level.isNotEmpty)
            _paragraph(
              'Niveau d’études : $level.',
            ),
          if (training.isNotEmpty)
            _paragraph(
              'Formation : $training.',
            ),
          if (academicYear.isNotEmpty)
            _paragraph(
              'Année académique : $academicYear.',
            ),
          if (registrationNumber.isNotEmpty)
            _paragraph(
              'Numéro de matricule : $registrationNumber.',
            ),
          _paragraph(
            'La présente attestation est délivrée à l’intéressé(e) '
            'pour servir et valoir ce que de droit.',
          ),
        ];

      case 'attestation_presence':
        return [
          _paragraph(
            'Nous attestons que '
            '${fullName.isEmpty ? "l’intéressé(e)" : fullName} '
            'était effectivement présent(e) dans notre structure '
            'pendant la période indiquée.',
          ),
          if (startDate.isNotEmpty || endDate.isNotEmpty)
            _paragraph(
              'Période : '
              '${startDate.isEmpty ? "à préciser" : startDate} '
              'au '
              '${endDate.isEmpty ? "à préciser" : endDate}.',
            ),
          _paragraph(
            'La présente attestation est délivrée pour servir '
            'et valoir ce que de droit.',
          ),
        ];

      case 'attestation_travail':
        return [
          _paragraph(
            'Nous attestons que '
            '${fullName.isEmpty ? "l’intéressé(e)" : fullName} '
            'a exercé au sein de '
            '${company.isEmpty ? "notre structure" : company}.',
          ),
          if (position.isNotEmpty)
            _paragraph(
              'Fonction occupée : $position.',
            ),
          if (startDate.isNotEmpty || endDate.isNotEmpty)
            _paragraph(
              'Période : '
              '${startDate.isEmpty ? "à préciser" : startDate} '
              'au '
              '${endDate.isEmpty ? "à préciser" : endDate}.',
            ),
          _paragraph(
            'La présente attestation est délivrée à la demande '
            'de l’intéressé(e) pour servir et valoir ce que de droit.',
          ),
        ];

      case 'attestation_stage':
        return [
          _paragraph(
            'Nous attestons que '
            '${fullName.isEmpty ? "l’intéressé(e)" : fullName} '
            'a effectué un stage au sein de '
            '${company.isEmpty ? "notre structure" : company}.',
          ),
          if (training.isNotEmpty)
            _paragraph(
              'Formation : $training.',
            ),
          if (startDate.isNotEmpty || endDate.isNotEmpty)
            _paragraph(
              'Période du stage : '
              '${startDate.isEmpty ? "à préciser" : startDate} '
              'au '
              '${endDate.isEmpty ? "à préciser" : endDate}.',
            ),
          _paragraph(
            'La présente attestation est délivrée pour servir '
            'et valoir ce que de droit.',
          ),
        ];

      default:
        return [
          _paragraph('Madame, Monsieur,'),
          _paragraph(
            message.isEmpty
                ? 'Veuillez trouver ci-joint le document généré '
                    'à partir des informations renseignées.'
                : message,
          ),
          _paragraph(
            'Je vous remercie de l’attention portée à la présente demande.',
          ),
          _paragraph(
            'Veuillez agréer, Madame, Monsieur, '
            'l’expression de ma considération distinguée.',
          ),
        ];
    }
  }

  static pw.Widget _infoLine(
    String label,
    String value,
  ) {
    if (value.isEmpty) {
      return pw.SizedBox();
    }

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.RichText(
        text: pw.TextSpan(
          children: [
            pw.TextSpan(
              text: '$label : ',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
              ),
            ),
            pw.TextSpan(
              text: value,
              style: const pw.TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _paragraph(
    String text,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.justify,
        style: const pw.TextStyle(
          fontSize: 11,
          lineSpacing: 3,
        ),
      ),
    );
  }

  static String _value(
    Map<String, String> data,
    List<String> keys, {
    String fallback = '',
  }) {
    for (final key in keys) {
      final value = data[key];

      if (value != null && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return fallback;
  }

  static String _formatDate(
    DateTime date,
  ) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }
}