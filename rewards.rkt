#lang racket

(provide feedback-for)

(require 2htdp/image
         "./score-util.rkt"
         "./rewards-util.rkt")

;Here, we'll specify a high level policy about rewards,
;  and their timings -- when students see what kind of feedback.

;Goals:
;  1) Feedback is ALWAY positive and constructive.
;  2) Sometimes feedback is funny, sometimes it's serious.  Always positive though.
;  3) Funny will be interleaved with serious.
;  4) Feedback has different levels of visual impact: normal, or full image.
;  5) Normal feedback is the most common.  Full image feedback is spaced out.
;  6) There's enough overall randomness in things to keep students from ignoring the feedback.

;Various things that might affect feedback:
;  1) Student just lost points
;  2) Student just gained points
;  3) Student is on an upward streak
;  4) Student is on a downward streak
;  5) Student has answered X questions
;  6) Student has been on tast for X minutes
;(We'll handle the obvious ones for now)

(define (serious-or-funny-phrase h)
  (if (even? (length h))
      (serious-phrase)
      (funny-phrase)))

(define (serious-or-funny-image h)
  (if (even? (length h))
      serious-reward 
      funny-reward))

(define (phrase-for h)
  (cond [(just-lost-points h)   (serious-phrase)]
        [(just-gained-points h) (serious-or-funny-phrase h)]
        [else (serious-phrase)]))

;Returns image function...
(define (image-for h)
  
  (cond
    ;Make them earn the visually intersesting rewards
    [(answered-less-than 5 h)     normal-reward]

    ;Don't let them get cool stuff too often.
    [(not (answered-multiple-of 3 h))     normal-reward]

    ;If they lost points, give them a serious background
    [(just-lost-points h)           serious-reward]

    ;If the gained points, sometimes funny, sometimes serious
    [(just-gained-points h)  (serious-or-funny-image h)]

    ;Shouldn't be there, but if we missed a case, normal is safe
    [else normal-reward]))

(define (feedback-for h)
  (define image-function  (image-for h))
  (define phrase          (phrase-for h))

  (image-function (first phrase)
                  (second phrase)))

  

(module+ test
  (feedback-for '(0 0 0 0 0 1))          ;Image, serious
  (feedback-for '(0 0 0 0 0 1 0 0 1))    ;Image, funny
  (feedback-for '(0 0 0 0 0 -1))         ;Image, serious
  (feedback-for '(0 0 0 0 0 -1 0 0 -1))  ;Image, serious
  
  (feedback-for '(0 0 0 ))  ;Text, serious (Not enough questions yet)

  (feedback-for '(0 0 0 0 0 0 1))  ;Text, serious
  )


