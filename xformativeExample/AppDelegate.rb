#
#  AppDelegate.rb
#  xformativeExample
#
#  Created by Matt Aimonetti on 1/30/12.
#  
#  Example of how to use NSCollectionView in MacRuby
#  
#  Check the MainMenu.xib file.
#  At the root of the xib, you will see a view, this view is used for each item drawn by the collection view.
#  The item view contains a label and a button. 
#    The label use a binding to the collection view's item representedObject.name (see the value binding)
#    The button is set to call the item_was_clicked action (aka method) from the AppDelegate class.
#
#  The array controller is bound the links array defined when the application finish launching. 
#  It's also set so its object controller maps to the Link class with two keys available: name and url.
#  The NSCollectionView is located inside the window's view's scroll view and is bound to the array controller.
#
# You can actually follow along with this objective-c guide, I stayed pretty close to Apple's example.
# http://developer.apple.com/library/mac/#documentation/cocoa/Conceptual/CollectionViews/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009030

class AppDelegate
  attr_accessor :window
  attr_accessor :links, :array_controller # outlets used to link the view objects to this code.
  
  def applicationDidFinishLaunching(a_notification)
    # create an array of links which will be used by the NSCollectionView
    self.links = [ Link.new("Matt's blog", "http://merbist.com"), 
                   Link.new("MacRuby's site", "http://macruby.org")
                  ]
  end
  
  # Action triggered when the button is clicked
  def item_was_clicked(sender)
    # Find the selected Link instance via the array controller and get its url attribute
    url_string = array_controller.selectedObjects.first.url
    if url_string
      # convert the url into a NSURL instance and open it in the browser.
      url = NSURL.URLWithString(url_string)
      NSWorkspace.sharedWorkspace.openURL(url)
    end
  end
  
end


# The class used by the collection view to bind the attributes to the view.
class Link
  attr_accessor :name, :url
  
  def initialize(name, url)
    self.name = name
    self.url = url
  end
end