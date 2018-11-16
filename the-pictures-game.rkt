#lang racket

(provide the-pictures-game)

(require ts-racket
         2htdp/image
         "./quizzes.rkt")



(require (prefix-in p: pict/code)
         (prefix-in p: pict))

(define example-color
  (random-choose 'orange 'yellow 'green 'blue 'purple))

(define (random-color)
  (random-choose 'red 'orange 'blue))

(define (random-size)
  (random-choose 10 30 60))

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

(define medium-set
  (example-set 10 two-circles))

(define hard-set
  (example-set 10 three-circles))




(define easy-set
  (example-set 10 one-circle))


(define random-questions-1
  (map (curry which-code-produced-this-shape easy-set) easy-set))

(define random-questions-2
  (map (curry which-shape-would-this-code-produce easy-set) easy-set))

(define random-questions-3
  (map write-the-code-to-produce-this-shape easy-set))


(define random-questions
  (append
   (shuffle (append (take random-questions-1 3)
                    (take random-questions-2 3)))
   (take random-questions-3 5)))



(define teaching-questions
  (list

   (yes-no-question "Let's code some pictures!"  'yes)

   (yes-no-question (stack "Take a look at this code:"
                           (code (circle 30 'solid 'red))
                           "Got it?")
                    'yes)

   (yes-no-question (stack "Type that code and see what happens!"
                           "Here it is again."
                           (code (circle 30 'solid 'red))
                           "Once you have tried it..."
                           "Did it make a blue circle?")
                    'no)

   (simple-question (stack "Now, if I were to ask you what code"
                           "would make a red circle, just like that one,"
                           "you would type:"
                           (code (answer (circle 30 'solid 'red)))
                           "Go ahead and try that!")
                    (curry equal?
                           (circle 30 'solid 'red)))


   (yes-no-question (stack "Pretty cool!"
                           "But there are more colors than just red, right?")
                    'yes)

   (simple-question (stack (row "Can you code a " (code circle))
                           "of the same size"
                           (row "but make it " (code '#,example-color) "?")
                           (row "Type your answer inside an " (code (answer ____)))
                           "filling in that blank with the code"
                           "to make your circle.")
                    (curry equal?
                           (circle 30 'solid example-color)))

   (yes-no-question (stack "HINT!"
                           "You can always test code here before answering."
                           "Just remember to wrap your answer inside a"
                           (code (answer ____))
                           "Do you understand?")
                    'yes)

   (simple-question (stack "How would you code an"
                           (row (code 'aquamarine) " " (code circle))
                           "of the same size?")
                    (curry equal?
                           (circle 30 'solid 'aquamarine)))

   (simple-question (stack "You are doing great!!"
                           "Serious question time."
                           (random-dude)
                           "Is this random dude"
                           (code (answer 'cool))
                           "or"
                           (row (code (answer 'creepy))  "?"))
                    (or/c 'cool 'creepy))

   (yes-no-question (stack "Now, let's change the size of our circles!"
                           "Ready?")
                    'yes)

   (simple-question (stack "This circles we have been making"
                           (row "have had a radius of " (code 30) ".")
                           (row "How would you code a " (code 'green) " circle.")
                           (row "with a radius of " (code 100) "?!"))
                    (curry equal?
                           (circle 100 'solid 'green)))

   (yes-no-question (stack "Congratulations!"
                           "Are you ready to test your knowledge against"
                           "our random question generator?")
                    'yes)


   (yes-no-question (stack (row "Okay, there will be " (length random-questions) " questions")
                           (random-dude)
                           "This weird creature believes in you."
                           "Are you ready?")
                    'yes)
   ))


(define qs
  (append teaching-questions
          random-questions))


(define (the-pictures-game)
  (apply start-quiz qs))

(module+ test
  (the-pictures-game))