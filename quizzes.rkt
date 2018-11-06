#lang racket

(provide start-quiz
         question
         must-equal
         give-points
         show-me
         answer
         answer!


         stack
         row

         t
         yes
         no

         plus-1
         say-yes
         say-no
         say-answer
         
         yes-no
         yes-no-question
         simple-question

         code

         start-over
         try


         define-example-template
         example-output
         example-code
         example-set
         example-equal?

         which-shape-would-this-code-produce
         which-code-produced-this-shape)

(require ts-racket
         2htdp/image
         (only-in racket/gui play-sound )
         racket/runtime-path
         "./image-util.rkt"
         "./rewards.rkt")

(define-runtime-path sounds "sounds")

(define right-sound (build-path sounds "right.wav"))    ; path to audio file (windows can only play .wav)
(define wrong-sound (build-path sounds "wrong.wav"))    ; path to audio file (windows can only play .wav)


;Add to player (or the context).
;Allow question effects to change the last shown message to players...
;  Maybe have a last-shown-prompt and a last-shown-feedback

(struct player   (last-shown data)  #:transparent)
(struct question (prompt evaluate)  #:transparent)

(define (make-player [d 0])
  (player #f d))


(define (answer-question the-player
                         their-answer
                         the-question)

  (define affect
    (if the-question
      ((question-evaluate the-question) their-answer)
      identity))

  (struct-copy player
               the-player
               [data (affect (player-data the-player))]))


(define (maybe-call q)
  (if (procedure? q) (q) q))



(define (show-player the-player
                     the-question)
  
  (define prompt
    (maybe-call (if (question? the-question)
                    (question-prompt the-question)
                    the-question)))
  
  (struct-copy player the-player
               [last-shown (or (frame (fluff (fluff prompt)))
                               (text "You're done!" 24 'green))]))



(struct context (previous player quiz question))

(define current #f)


(define (current-question)
  (context-question current))

(define (current-player)
  (context-player current))

(define (previous-player)
  (if (context-previous current)
      (context-player
       (context-previous current))
      #f
      ))

(define (current-quiz)
  (context-quiz current))

(define (display-context c)
  (displayln (display-player (context-player c))) )


(define (color-for-score d)
  (if (positive? d)
      'darkgreen
      'darkred))


(define (score-change p)
  (define previous-score (player-data (previous-player)))
  (define current-score  (player-data p))

  (- current-score previous-score))


(define (context-history (c current))
  (if (not c)
      '()
      (append (context-history (context-previous c))
              (list c))))

(define (score-history)
  (map (compose player-data context-player) (context-history)))

(define (reward p)
  (frame  (fluff  (feedback-for (score-history))  'darkgray)))

(define (describe-score-change p)
  (define previous-score (player-data (previous-player)))
  
  (define change
    (score-change p))

  (define change-amount
    (cond [(positive? change) (t (~a "+" change) 'green)]
          [(negative? change) (t change 'red)]
          [else (t "+0" 'yellow)]))

  (define change-amount-icon
    (rotate
     (random -25 25)
     (overlay change-amount
              (circle (image-width change-amount) 'solid 'black))))

   (beside
    change-amount-icon
    (square 50 'solid 'transparent)
    (rotate
     (random -5 5)
     (reward p))))

;TODO: Show various rewards (function of how much the points changed)
(define (show-score p)

   (frame
    (fluff
     (fluff
      (stack
       (if (previous-player)
           (begin
             (if (positive? (score-change p))
                 (play-sound right-sound #t)
                 (play-sound wrong-sound #t))
             (describe-score-change p))
           "Good luck!!")
       (text (~a "Total: "
                 (player-data p))
             24
             (color-for-score
              (player-data p)))))
     'lightgray)))

(define (display-player p)
  (above/align "left"
   (rectangle 10 20 'solid 'white)
               (scale 0.75 (show-score p))
   (rectangle 300 10 'solid 'white)
   (or (player-last-shown p) empty-image)
   ))

(define (update-current! c)
  (set! current c)
  (display-context c))


(define (show-me)
  (update-current!
   (context
    #f
    (show-player (current-player)
                 (current-question))
    (current-quiz)
    (current-question))))

(define (start-quiz  #:player (the-player (make-player))
                     . questions)

  (update-current!
   (context current 
            (show-player
             the-player
             (row "Game started!  Use " (code (show-me)) "to see the current question."))
            questions
            (first questions))))


(define (answer! a)

  
  (define remaining
    (member (current-question)
            (current-quiz)))
  
  (define new-player
    (answer-question (current-player) a (current-question)))

  (define next-question
    (and remaining
         (not (empty? remaining))
         (< 1 (length remaining))
         (second remaining)))

  (define question-to-show
    (if (>= (player-data new-player)
            (player-data (current-player)))
        next-question
        (current-question)))

  (define to-show
    (or question-to-show
        (final-scores new-player (current-quiz))))

  (update-current!
   (context
    current
    (show-player new-player to-show)
    (current-quiz)
    to-show))
  )

(define (start-over)
  (set! current (first (context-history)))

  (show-me))

(define (final-scores player quiz)
  (question (stack "You're done!"
                   (row "You answered " (length quiz) " questions, and got " (player-data player) " points!")
                   (row "To  again, you can type " (code (start-over)))
                   (random-dude)
                   "This random creature is proud of you.")
            (must-equal #t
                        #:reward  (give-points 0)
                        #:penalty (give-points 0))))


(define answer answer!)

(define-syntax-rule (try s)
  (begin
    (displayln "Nice!  Keep experimenting.")
    s))



(define (give-points n)
  ;Show the player something positive or negative based on value of n...
  (curry + n))


(define (must-equal n #:reward right
                      #:penalty wrong)
  (lambda (a)
    (if ((and/c n) a)
        right
        wrong))) 


;=====RESPONSES=========

(define (yes)
  (answer 'yes))

(define (no)
  (answer 'no))

;=====QUESTION TYPES====
(define (t s (color 'black))
  (cond [(image? s)  s]
        [(p:pict? s)   (p:pict->bitmap s)]
        [else (text (~a s) 24 color)]))



(define (row . ss)
  (apply (curry beside/align "bottom")
         (map t (add-between ss ""))))

(define (stack . ss)
  (apply (curry above/align "left")
         (map t (add-between ss ""))))




(define plus-1 (t "+1" 'darkgreen))
(define say-yes    (t "(yes)" 'darkgreen))
(define say-no     (t "(no)"  'darkred))

(define (say-answer a)
  (p:scale (p:code (answer '#,a)) 2))

(define (yes-no s)
  (above/align "left"
               (t s)
               (t "")
               (fluff
                (frame
                 (fluff (row "Type " say-yes " or " say-no))))))


(define/contract (yes-no-question s correct-answer)
  (-> (or/c string? image?) (or/c 'yes 'no) question?)
  (question (yes-no s)
            (must-equal (or/c correct-answer)
                        #:reward  (give-points 1)
                        #:penalty (give-points -1))))



(define/contract (simple-question s correct-answer)
  (-> (or/c string? image?) any/c question?)
  (question (t s)
            (must-equal (or/c correct-answer)
                        #:reward  (give-points 1)
                        #:penalty (give-points -1))))


(require (prefix-in p: pict))
(require (prefix-in p: pict/code))
(define-syntax-rule (code exp)
  (p:pict->bitmap
   (p:scale (p:code exp) 2)))

(struct example (code stx) #:transparent)

(define (strip-code-lines l)
  (define (code-line? x)
    (and (list? x)
         (eq? 'code:line (first x))))
  
  (if (or (not (list? l)) (empty? l))
      l
      (map strip-code-lines
           (filter (not/c code-line?) l))))



(define-namespace-anchor a)
(define ns (namespace-anchor->namespace a))
 
(define (example-output e)
  (define non-stripped
    (syntax->datum (example-stx e)))


  (define stripped
    (strip-code-lines non-stripped))

  (eval stripped
        ns))

(define (example-equal? a b)
  (equal? (example-output a)
          (example-output b)))


(define-syntax-rule (define-example-template id the-code)
  (define id (thunk (let ([temp #`the-code])
                      (example (p:code #,temp) temp)))))


(define (example-set n f)
  (remove-duplicates
   (map (thunk* (f)) (range n))
   example-equal?))


;Question types:

;Takes a set and a single example in that set:
; * Which of the following does this code produce?
; * Which of the following codes produces this output?

;Takes a single example
; * How many parens does this expression have?
; * How many primitive shapes are there?
; * How many shape combiners are there?
; * Write the code to make this shape.
; * Copy this expression (just type it)...  WARMUPs...

(define (number->answer-letter i)
  (define answer-letters
    (list (or/c 'a 'A "a" "A" 1)
          (or/c 'b 'B "b" "B" 2)
          (or/c 'c 'C "c" "C" 3)
          (or/c 'd 'D "d" "D" 4)))
  
  (list-ref answer-letters i))

(define (which-code-produced-this-shape set element)
  (define wrong-answer-bank
    (map example-code
         (filter (not/c (curry example-equal? element)) set)))

  (define right-answer (example-code element))

  (define wrong-answers
    (take (shuffle wrong-answer-bank) 2))

  (define answers (shuffle (cons right-answer wrong-answers)))

  (define right-answer-letter
    (number->answer-letter (index-of answers right-answer)))
  
  (simple-question (stack "Which code makes this?"
                          "(HINT: It is NOT cheating to type code and experiment...)"
                           (example-output element)

                           "Type: "
                           (row (code (answer 'a)) " for " (p:scale (first answers)  2 ))
                           (row (code (answer 'b)) " for " (p:scale (second answers) 2 ))
                           (row (code (answer 'c)) " for " (p:scale (third answers)  2 )))
                    right-answer-letter))


(define (which-shape-would-this-code-produce set element)
  (define wrong-answer-bank
    (map example-output
         (filter (not/c (curry example-equal? element)) set)))

  (define right-answer (example-output element))

  (define wrong-answers
    (take (shuffle wrong-answer-bank) 3))

  (define answers (shuffle (cons right-answer wrong-answers)))

  (define right-answer-letter
    (number->answer-letter (index-of answers right-answer)))
  
  (simple-question (stack "Which shape will this code make?"
                          "(HINT: It is NOT cheating to type code and experiment...)"
                           (p:scale (example-code element) 2)

                           "Type: "
                           (row (code (answer 'a)) " for   " (first answers))
                           (row (code (answer 'b)) " for   " (second answers))
                           (row (code (answer 'c)) " for   " (third answers))
                           (row (code (answer 'd)) " for   " (fourth answers)))
                    right-answer-letter))
