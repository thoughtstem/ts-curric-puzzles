#lang racket

(provide pictures-level-1)

(require ts-racket
         2htdp/image
         "./quizzes.rkt")



(require (prefix-in p: pict/code)
         (prefix-in p: pict))


(define (random-color)
  (random-choose 'red 'orange 'yellow 'green 'blue 'purple))

(define (random-size)
  (random-choose 10 20 30))

(define (random-circle-code)
  `(circle ,(random-size) 'solid ',(random-color)))

(define-example-template one-circle 
  #,(random-circle-code))

(define-example-template two-circles 
  (#,(random-choose 'above 'beside)
     (code:line )
     #,(random-circle-code)
     (code:line )
     #,(random-circle-code)))

(define-example-template three-circles 
  (#,(random-choose 'above 'beside)
   (code:line )
   #,(random-circle-code)
   (code:line )
    (#,(random-choose 'above 'beside)
     (code:line )
     #,(random-circle-code)
     (code:line )
     #,(random-circle-code))))


(define easy-set
  (example-set 10 one-circle))

(define medium-set
  (example-set 10 two-circles))


(define hard-set
  (example-set 10 three-circles))



(define qs
  (list

   (which-shape-would-this-code-produce hard-set (first hard-set))
   
   (which-shape-would-this-code-produce easy-set (first easy-set))

   (which-code-produced-this-shape medium-set (first medium-set))

   (which-shape-would-this-code-produce medium-set (first medium-set))

   #;(yes-no-question "Are you ready to code some pictures???"   'yes)

   #;(simple-question (stack "Read this code..."
                           "How many parens?"
                           (example-code snippet1)
                           "Here's what it makes..."
                           (example-output snippet1))
                    (or/c 'a 'b))


   #;(simple-question (stack "Read this code..."
                             "How many parens?"
                             (example-code snippet2)
                             "Here's what it makes..."
                             (example-output snippet2))
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