#lang racket

(provide fluff
         random-rotate)

(require 2htdp/image)

(define (random-rotate i)
  (rotate (random -15 15)
          i))

(define (fluff i (color 'transparent))
  (overlay
   i
   (rectangle (+ 10 (image-width i))
              (+ 10 (image-height i))
              'solid
              color)))
