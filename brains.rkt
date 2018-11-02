#lang racket

(provide brain
         brain-quote)

(require ts-racket
         2htdp/image
         racket/runtime-path
         "./image-util.rkt")
         
(define-runtime-path images "images")

(define (num-brains)
  (define things (directory-list (build-path images "brains")))

  (define (is-brain-img? t)
    (and
     (string-prefix? (~a t) "brain")
     (string-suffix? (~a t) "jpg")))

  (length (filter is-brain-img? things)))

(define (brain)
  (define n (add1 (random (num-brains))))
  (bitmap/file (build-path images "brains" (~a "brain" n ".jpg"))))


(define (brain-quote top bottom)
  (overlay/align "middle" "bottom"
                 (random-rotate
                  (fluff (text bottom 24 'white) 'black))
                 (overlay/align "middle" "top"
                                (random-rotate
                                 (fluff (text top 30 'white) 'black))
                                (scale-to-fit (brain) 350))))


(module+ test
  (brain-quote "Hello" "world"))