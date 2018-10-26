#lang racket

(provide (all-defined-out))

(define (second-to-last h)
  (second (reverse h)))

(define (answered-more-than n h)
  (< n (length h)))

(define (answered-less-than n h)
  (> n (length h)))

(define (answered-multiple-of n h)
  (= 0 (remainder (length h) n)))

(define (just-f-points f h)
  (and
   (answered-more-than 1 h)
   (f (second-to-last h)
      (last h))))


(define (just-lost-points h)
  (just-f-points > h))

(define (just-gained-points h)
  (just-f-points < h))


