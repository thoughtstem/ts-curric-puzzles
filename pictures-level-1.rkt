#lang racket

(provide pictures-level-1)

(require ts-racket
         2htdp/image
         "./quizzes.rkt")

(require (prefix-in p: pict/code))


(define (random-color)
  (random-choose 'red 'orange 'yellow 'green 'blue 'purple))

(define (random-circle-code)
  `(circle 20 'solid ',(random-color)))



(define qs
  (list

   #;(yes-no-question "Are you ready to code some pictures???"   'yes)

   (simple-question (stack "Read this code..."
                           "Pick 'a 'b or 'c"
                           (p:code (#,(random-choose 'above 'beside)
                                    #,(random-circle-code)
                                    #,(random-circle-code))))
                    (or/c 'a 'b))


   (simple-question (stack "Write some code that "
                           "Puts two red circles above each other"
                           "<<More....>>"
                           )
                    (curry equal?
                           (above
                            (circle 20 'solid 'red)
                            (circle 20 'solid 'red))))
   
))





(define (pictures-level-1)
  (apply start-quiz qs))

(module+ test
  (pictures-level-1))