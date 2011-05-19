#
# Internal Network Fingerprinting
# Discover devices and applications in the internal network of the victim using
# signatures like default logo images/favicons (partially based on the Yokoso idea).
# It does this by loading images on common/predefined local network
# IP addresses then matching the image width, height and path to those
# for a known device.
#
# TODO LIST
# Add IPv6 support
# Add HTTPS support
# -  Devices with invalid certs are blocked by IE and FF by default
# Improve stealth
# -  Load images with CSS "background:" CSS to avoid http auth login popups
# Improve speed
# -  Make IP addresses a user-configurable option rather than a hard-coded list
# -  Detect local ip range first - using browser history and/or with java
#    - History theft via CSS history is patched in modern browsers.
#    - Local IP theft with Java is slow and may fail


class Internal_network_fingerprinting < BeEF::Core::Command
  
  def initialize
    super({
      'Name' => 'Internal Network Fingerprinting',
      'Description' => 'Discover devices and applications in the internal network of the victim using signatures like default logo images/favicons (partially based on the Yokoso idea)',
      'Category' => 'Recon',
      'Author' => ['bcoles@gmail.com', 'wade', 'antisnatchor'],
      'File' => __FILE__
    })

    set_target({
        'verified_status' =>  VERIFIED_USER_NOTIFY,
        'browser_name' =>     FF  # works also in FF 4.0.1
    })

    set_target({
        'verified_status' =>  VERIFIED_NOT_WORKING,
        'browser_name' =>     O
    })

    set_target({
        'verified_status' =>  VERIFIED_USER_NOTIFY,
        'browser_name' =>     IE
    })
    
    use_template!
  end
  
  def callback
    content = {}
    content['device'] =@datastore['device'] if not @datastore['device'].nil?
    content['url'] = @datastore['url'] if not @datastore['url'].nil?
    if content.empty?
      content['fail'] = 'No devices/applications have been discovered.'
    end
    save content
  end
end