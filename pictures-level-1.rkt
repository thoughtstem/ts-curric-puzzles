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

   #;(yes-no-question (stack "The code you just saw will make a..."
                             (code circle)
                             (row "with a radius of " (code 30) " pixels")
                             (row "a mode of " (code 'solid))
                             (row "and a color of " (code 'red))
                             (row "Type " (code (yes)) " to continue!"))
                      'yes)
   
   #;(simple-question (stack "And here's that circle!"
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

   (simple-question (stack (row "Can you code a " (code circle))
                           "of the same size"
                           (row "but make it " (code #,example-color) "?")
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
                           (row (code aquamarine) " " (code circle))
                           "of the same size?")
                    (curry equal?
                           (circle 30 'solid 'aquamarine)))

   (simple-question (stack "You are doing great!!"
                           "Serious question time."
                           (random-dude)
                           "Is this random dude"
                           (code (answer 'cool))
                           "or"
                           (code (answer 'creepy)))
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


   #;(simple-question (stack "Read this code..."
                             "Pick 'a 'b or 'c"
                             (p:code (#,(random-choose 'above 'beside)
                                      #,(random-circle-code)
                                      #,(random-circle-code))))
                      (or/c 'a 'b))


   #;(simple-question (stack "Write some code that "
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