#lang racket

(provide positive-phrase)
(provide very-positive-phrase)

(define (positive-phrase)
  (~a (awesome) " " (answer)))

(define (very-positive-phrase)
  (~a (incredibly) " " (awesome) " " (answer)))



(define-syntax-rule (define-random id things)
  (begin
    (provide id)
    (define (id)
      (define l things)
      (list-ref l (random (length l))))))

(define-random opinion
  '(opinion
    thoughts
    thinking
    assessment
    analysis
    feedback
    reflection))

(define-random incredibly
  '(super
    very
    incredibly
    quite
    extremely
    splendidly
    awesomely))

(define-random awesome
  '(awesome
    excellent
    exceptional
    favorable
    great
    marvelous
    satisfactory
    superb
    wonderful
    ace
    boss
    nice
    pleasing
    rad
    super
    superior
    worthy
    admirable
    agreeable
    commendable
    deluxe
    first-class
    first-rate
    gratifying
    honorable
    neat
    precious
    shipshape
    splendid
    stupendous))


(define-random answer
  '(response
    answer
    job))


(define-random growth-mindset-phrase
  '(
    "Your brain is like a muscle."
    "Everything you do builds new brain connections."
    "You can do anything with enough effort."
    "Learning makes you a better person."
    "There is no such thing as failure."
    "When you struggle, you learn."
    "The most important thing? Learning to love learning."
    "We grow when we face challenges."
    "\"Smart\" is something you become."
    "No one is born smart.  We become smart."
    "You can always improve."
    "You can always get better."
    "The only way to fail is to give up."
    "Practice makes your brain stronger."
    "Practice makes the brain faster."
    "Practice makes the brain more flexible."
    "Embrace challenges."
    "Keep going, even when things get hard."
    "It might be easy now, but train for when it's hard"
    "Never fear challenges."
    "Brains can grow, like trees or plants."
    "Always remind your friends to keep trying."
    "We can help each other's brains grow by teaching them."
    "Those who work hard become smart."
    "Give it your all."
    "Never give up."
    "Your effort is what makes you awesome."
    "You can do anything with enough effort."
    "You can be anything if you try hard enough."
    "Try your best every day."
    "Never quit.  Never give up."
    "Thinking makes your brain grow."
    "Some people don't notice their brains.  But you do."
    "Practice makes progress.  (Not pefect.)"
    "Dig deep and stick with it."
    "Keep calm and keep going."
    "Learn from your successes.  Learn from your mistakes."
    "You can improve by working hard."
    "Never surrender!"
    "Do your best at all times."
    "Self-reflection is the key to success."
    "Effort can overcome any challenge."
    "Every problem you solve makes you a better solver."
    "Easy or hard.  Solving problems trains your brain."
    "Never be afraid of challenge."
    "Never be afraid to try."
    "Struggle leads to strength."
    "Grow every day."
    "Hard work is the key to everything."
    "When you struggle you grow."
    "You can learn from mistakes or successes.  Either one."
    "Your brain can stretch."
    "Your brain can be come more flexible with training."
    "Effort leads to improvement."
    "Neuroplasticity  That means: \"brain change.\""
    ))
