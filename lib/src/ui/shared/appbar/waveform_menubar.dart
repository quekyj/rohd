import 'package:flutter/material.dart';

class WaveformMenubar extends StatelessWidget {
  const WaveformMenubar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.yellow,
          child: Row(
            children: <Widget>[
              Expanded(
                child: MenuBar(
                  children: <Widget>[
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Open File...'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Switch File...'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Reload...'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Save state...'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&File'),
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Zoom in'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Zoom out'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Zoom to fit'),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Go to start...'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Go to end...'),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child:
                              const MenuAcceleratorLabel('Toggle side panel'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle menu'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle toolbar'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle overview'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle statusbar'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&View'),
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Zoom in'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Zoom out'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Zoom to fit'),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Go to start...'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Go to end...'),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child:
                              const MenuAcceleratorLabel('Toggle side panel'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle menu'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle toolbar'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle overview'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Toggle statusbar'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&Settings'),
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Quick start'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Control keys'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Mouse gestures'),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('Show logs'),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: 'test');
                          },
                          child: const MenuAcceleratorLabel('About'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&Help'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.file_open)),
                IconButton(onPressed: () {}, icon: Icon(Icons.download)),
                IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                const VerticalDivider(
                  width: 20,
                  thickness: 1,
                  color: Colors.black,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.zoom_in)),
                IconButton(onPressed: () {}, icon: Icon(Icons.zoom_out)),
                IconButton(onPressed: () {}, icon: Icon(Icons.zoom_in_map)),
                const VerticalDivider(
                  width: 20,
                  thickness: 1,
                  color: Colors.black,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.fast_rewind)),
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous)),
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
                IconButton(onPressed: () {}, icon: Icon(Icons.fast_forward)),
                IconButton(onPressed: () {}, icon: Icon(Icons.space_bar)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_time)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
