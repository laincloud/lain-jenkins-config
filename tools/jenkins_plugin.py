import ConfigParser

def get_plugins():
    config = ConfigParser.ConfigParser()
    config.readfp(open('plugin.cfg'))
    sec = 'plugins'
    plugins = []
    plugins_items = config.items(sec)
    for plugins_item in plugins_items:
        plugins.append(plugins_item[1])
    return plugins

def install_plugins(server):
    plugins = get_plugins()
    for plugin in plugins:
        print 'install %s %s' % (plugin, server.install_plugin(plugin, True))