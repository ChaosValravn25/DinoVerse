import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatus extends StatefulWidget {
  final Widget child;

  const ConnectionStatus({super.key, required this.child});

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  late Stream<List<ConnectivityResult>> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusHeight = screenHeight * 0.05; // 5% de la altura de la pantalla

    return StreamBuilder<List<ConnectivityResult>>(
      stream: _connectivityStream,
      builder: (context, snapshot) {
        final connected = snapshot.hasData &&
            snapshot.data!.any((result) => result != ConnectivityResult.none);

        return Column(
          children: [
            Expanded(child: widget.child),
            Visibility(
              visible: !connected, // Muestra solo cuando no hay conexión
              child: Container(
                width: screenWidth, // Ocupa el ancho completo de la pantalla
                height: statusHeight, // Altura proporcional al 5% de la pantalla
                padding: EdgeInsets.all(statusHeight * 0.2), // Padding proporcional
                color: Colors.red[700], // Solo rojo cuando no hay conexión
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.signal_wifi_off,
                      color: Colors.white,
                      size: statusHeight * 0.6, // Tamaño del ícono proporcional
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sin conexión',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: statusHeight * 0.4, // Tamaño de fuente proporcional
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}