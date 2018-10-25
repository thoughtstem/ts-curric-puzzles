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



