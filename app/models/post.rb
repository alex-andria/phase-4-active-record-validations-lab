class Post < ApplicationRecord

    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]} 
    # or {in: w%(Fiction Non-Fiction)}
    validate :title_clickbaity?

    # Custom Validations

    # Constants returns an array of symbols that represent the constants defined in a class
    # Variable type that  always starts with a capital letter. 
    # They can only be defined outside of methods, unless you use metaprogramming.
    CLICKBAIT_PHRASES = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def title_clickbaity?
        if CLICKBAIT_PHRASES.none?  {|phrase| phrase.match title }
            errors.add(:title, "must be clickbait")
        end
    end
end
