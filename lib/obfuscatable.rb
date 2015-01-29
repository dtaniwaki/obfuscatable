module Obfuscatable

  def obfuscatable(options = {})
    require 'scatter_swap'

    include InstanceMethods
    cattr_accessor :obfuscatable_spin
    self.obfuscatable_spin = (options[:spin] || obfuscatable_default_spin)
  end

  def self.hide(id, spin)
    ScatterSwap.hash(id, spin)
  end

  def self.show(id, spin)
    ScatterSwap.reverse_hash(id, spin)
  end


  module ClassMethods
    def find_obfuscated(*args)
      scope = args.slice!(0)
      options = args.slice!(0) || {}
      if has_obfuscated_id?
        if scope.is_a?(Array)
          scope.map! {|a| deobfuscatable(a).to_i}
        else
          scope = deobfuscatable(scope).to_i
        end
      end
      find(scope)
    end

    def has_obfuscated_id?
      true
    end

    def deobfuscatable(obfuscated_id)
      Obfuscatable.show(obfuscated_id, self.obfuscatable_spin)
    end

    # Generate a default spin from the Model name
    # This makes it easy to drop obfuscatable onto any model
    # and produce different obfuscated ids for different models
    def obfuscatable_default_spin
      alphabet = Array("a".."z")
      number = name.split("").collect do |char|
        alphabet.index(char)
      end
      number.shift(12).join.to_i
    end

  end

  module InstanceMethods
    def to_param
      Obfuscatable.hide(self.id, self.class.obfuscatable_spin)
    end

    def deobfuscatable(obfuscated_id)
      self.class.deobfuscatable(obfuscated_id)
    end
  end
end

ActiveRecord::Base.extend Obfuscatable
ActiveRecord::Base.extend Obfuscatable::ClassMethods
ActiveRecord::Relation.__send__ :include, Obfuscatable::ClassMethods
