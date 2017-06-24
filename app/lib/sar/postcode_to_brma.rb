module SAR
  class PostcodeToBrma
    def initialise(postcode)
      @postcode = postcode
    end

    def convert
      p normalized_postcode
    end

    private

    attr_reader :postcode

    def normalized_postcode

    end
  end
end
