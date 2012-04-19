# Contractual

This gem provides limited support for the utilization of interfaces in Ruby. The approach here is 
nearly idetnical to one suggested by Mark Bates at http://metabates.com/2011/02/07/building-interfaces-and-abstract-classes-in-ruby/.
It didn't seem like this had been turned into a gem yet, so I thought I might go ahead and put it together in
case others found the technique as helpful as I had. 

## What's this all about?

An **interface** is a logical description of the role of an entity within the system; basically it is a construct which specifies a contract for the behavior of a component in an application. You might be thinking: hey, I've got all these RSpec/Cucumber/etc. focused behavior descriptions -- surely you're not saying I *repeat* myself? Well, not exactly. Specifications give us programmatic descriptions of how a given entity should behave in certain situations. These can *include* contracts but potentially go significantly deeper, since they can specify just about any behavior you can imagine. An interface is somewhat simpler in comparison: it's more or less just a hint that a given method must be implemented by a subclass. So you specify 'implement this method' and 'implement that method' in order to have an 'official' whatever-kind-of-entity.

The basic idea here is to give hints to developers extending your API that aren't just in the form of shared RSpec examples, but rather embedded in the source of the superclass. Effectively, this supports the 'L' in SOLID -- making it easier to substitute subclasses in a dynamic language, ensuring that certain methods are implemented.

Please note that there are some limitations as to the utility of this approach, perhaps most importantly the one that Bates himself identified -- that the interface hints aren't going to show up, automagically anyway, in documentation. (As a note on good practice it probably makes sense to describe these as part of the documentation for the class.) Furthermore, please note that given there's no compiler for Ruby, the associated contractual warnings only 'kick in' the first time an unimplemented contractually-obligated method is invoked.

## Installation

Add this line to your application's Gemfile:

    gem 'contractual'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install contractual

## Usage

Consider a canonical superclass.

    class Vehicle
      def drive(passengers, destination)
        load passengers
        follow Route.new(@current_location, destination)
        unload passengers
      end
    end
  
See all the methods have to be implemented for this to work? Let's specify these as part of the interface:

    class Vehicle
    
      must_implement :load, :passengers
      must_implement :follow, :route
      must_implement :unload, :passengers
    
      def move(passengers, destination)
        load passengers
        follow Route.new(@current_location, destination)
        unload passengers
      end
    end

Let's suppose we've been handed this interface from another developer. How do we make a custom subclass? Our first attempt at implementing might look something like this:

    class Zeppelin
    
      def load(passengers); @passengers << passengers; end
      def unload(passengers); @current_location << passengers; @passengers = []; end
    
     end
   
So now when we try to invoke Zeppelin.move, we'll get an exception warning us that Zeppelin is obligated to implement a method 'follow' from the interface Vehicle. This is the 'hint' that the implementing developer has a bit more work to do before they can use this custom class smoothly with the rest of the system. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks!

Many thanks go to Mark Bates for the idea for this gem.