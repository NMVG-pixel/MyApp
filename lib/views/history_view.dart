import 'package:flutter/material.dart';

import '../models/history_item_model.dart';
import '../models/document_model.dart';
import '../controllers/document_controller.dart';
import '../services/history_service.dart';
import 'document_generating_view.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({
    super.key,
  });

  @override
  State<HistoryView> createState() =>
      _HistoryViewState();
}

class _HistoryViewState
    extends State<HistoryView> {
  late Future<List<HistoryItemModel>>
      _historyFuture;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    _historyFuture =
        HistoryService.getHistory();
  }

  Future<void> _refreshHistory() async {
    setState(() {
      _loadHistory();
    });

    await _historyFuture;
  }

  Future<void> _deleteItem(
    HistoryItemModel item,
  ) async {
    await HistoryService.deleteHistoryItem(
      item.id,
    );

    if (!mounted) return;

    setState(() {
      _loadHistory();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Document supprimé de l’historique.',
        ),
      ),
    );
  }

  Future<void> _clearHistory() async {
    await HistoryService.clearHistory();

    if (!mounted) return;

    setState(() {
      _loadHistory();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Historique supprimé.',
        ),
      ),
    );
  }

  Future<void> _openDocument(
    HistoryItemModel item,
  ) async {
    final documents =
        DocumentController().getDocuments();

    DocumentModel? selectedDocument;

    for (final document in documents) {
      if (document.id == item.documentId) {
        selectedDocument = document;
        break;
      }
    }

    if (selectedDocument == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ce document n’est plus disponible.',
          ),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DocumentGeneratingView(
          document: selectedDocument!,
          formData: item.formData,
          saveToHistory: false,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day =
        date.day.toString().padLeft(2, '0');

    final month =
        date.month.toString().padLeft(2, '0');

    final hour =
        date.hour.toString().padLeft(2, '0');

    final minute =
        date.minute.toString().padLeft(2, '0');

    return '$day/$month/${date.year} à $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor =
        Color(0xFF000666);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Historique',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 0,
        actions: [
          FutureBuilder<List<HistoryItemModel>>(
            future: _historyFuture,
            builder: (context, snapshot) {
              final hasHistory =
                  snapshot.data?.isNotEmpty ?? false;

              if (!hasHistory) {
                return const SizedBox.shrink();
              }

              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'clear') {
                    _showClearConfirmation();
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem<String>(
                    value: 'clear',
                    child: Text(
                      'Effacer l’historique',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHistory,
        child: FutureBuilder<List<HistoryItemModel>>(
          future: _historyFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            if (snapshot.hasError) {
              return ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 160),
                  Center(
                    child: Text(
                      'Impossible de charger l’historique.',
                    ),
                  ),
                ],
              );
            }

            final history =
                snapshot.data ?? [];

            if (history.isEmpty) {
              return ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 110),

                  Icon(
                    Icons.history_outlined,
                    size: 80,
                    color: primaryColor.withOpacity(
                      0.35,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'Votre historique est vide',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Text(
                      'Les documents que vous générerez '
                      'apparaîtront ici.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF454652),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              physics:
                  const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];

                return Dismissible(
                  key: ValueKey(item.id),
                  direction:
                      DismissDirection.endToStart,
                  background: Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 12,
                    ),
                    padding:
                        const EdgeInsets.only(
                      right: 20,
                    ),
                    alignment:
                        Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: (_) async {
                    return await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Supprimer le document ?',
                              ),
                              content: Text(
                                'Voulez-vous supprimer « ${item.documentTitle} » de votre historique ?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      false,
                                    );
                                  },
                                  child:
                                      const Text(
                                    'Annuler',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      true,
                                    );
                                  },
                                  child: const Text(
                                    'Supprimer',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                  },
                  onDismissed: (_) {
                    _deleteItem(item);
                  },
                  child: _buildHistoryCard(
                    item,
                    primaryColor,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    HistoryItemModel item,
    Color primaryColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color:
                primaryColor.withOpacity(0.08),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.description_outlined,
            color: Color(0xFF000666),
          ),
        ),
        title: Text(
          item.documentTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding:
              const EdgeInsets.only(top: 5),
          child: Text(
            _formatDate(item.createdAt),
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF454652),
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFF454652),
        ),
        onTap: () {
          _openDocument(item);
        },
      ),
    );
  }

  void _showClearConfirmation() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Effacer l’historique ?',
          ),
          content: const Text(
            'Tous les documents de votre historique seront supprimés.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Annuler',
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _clearHistory();
              },
              child: const Text(
                'Effacer',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}