#lang racket

(provide pictures-level-1)

(require ts-racket
         2htdp/image
         "./quizzes.rkt")

(require (prefix-in p: pict/code))

(define example-color
  (random-choose 'orange 'yellow 'green 'blue 'purple))

(define (random-color)
  (random-choose 'red 'orange 'yellow 'green 'blue 'purple))

(define (random-circle-code)
  `(circle 20 'solid ',(random-color)))



(define qs
  (list

   #;(yes-no-question "Are you ready to code some pictures???"   'yes)

   ;(yes-no-question "Let's code some pictures!"  'yes)

   (yes-no-question (stack "Take a look at this code:"
                           (code (circle 30 'solid 'red))
                           (row "Then type " (code (yes)) " to continue."))
                    'yes)

   (yes-no-question (stack "The code you just saw will make a..."
                           (code circle)
                           (row "with a radius of " (code 30) " pixels")
                           (row "a mode of " (code 'solid))
                           (row "and a color of " (code 'red))
                           (row "Type " (code (yes)) " to continue!"))
                    'yes)
   
   (simple-question (stack "And here's that circle!"
                           (circle 30 'solid 'red)
                           "Now you try."
                           "Type the code to make this circle."
                           "(you can look at the code by scrolling up!)"
                           "When you get the code exactly right,"
                           (row "type " (code (answer___)))
                           "with the circle code in that blank.")
                    (curry equal?
                           (circle 30 'solid 'red)))

   (yes-no-question (stack "Pretty cool!"
                           "But there are more colors than just red, right?")
                    'yes)

   (simple-question (stack "I challenge you!"
                           (row "Can you code a " (code circle))
                           "with the same size and mode"
                           (row "but make it " (code #,example-color) "?")
                           (row "Type your answer inside an " (code (answer ____)))
                           "just like before.")
                    (curry equal?
                           (circle 30 'solid example-color)))


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