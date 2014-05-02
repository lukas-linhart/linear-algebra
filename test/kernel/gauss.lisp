#|

  Linear Algebra in Common Lisp Unit Tests

  Copyright (c) 2011-2014, Odonata Research LLC

  Permission is hereby granted, free  of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction,  including without limitation the rights
  to use, copy, modify,  merge,  publish,  distribute,  sublicense, and/or sell
  copies of the  Software,  and  to  permit  persons  to  whom  the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and  this  permission  notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED  "AS IS",  WITHOUT  WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT  NOT  LIMITED  TO  THE  WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE  AND  NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT  HOLDERS  BE  LIABLE  FOR  ANY  CLAIM,  DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

|#

(in-package :linear-algebra-test)

(define-test initialize-pivot-selection-vector
  (:tag :gauss)
  (assert-rational-equal
   #(0 1 2 3 4 5)
   (linear-algebra-kernel::initialize-pivot-selection-vector 6)))

(define-test pivot-search-array
  (:tag :gauss)
  (assert-eq
   1 (linear-algebra-kernel::pivot-search-array
      #2A((1.1 1.4 1.3 1.2)
          (1.4 2.2 2.3 2.1)
          (1.3 2.3 3.3 3.2)
          (1.2 2.1 3.2 4.4)) 0))
  (assert-eq
   2 (linear-algebra-kernel::pivot-search-array
      #2A((1.1 1.4 1.3 1.2)
          (1.4 2.2 2.3 2.1)
          (1.3 2.3 3.3 3.2)
          (1.2 2.1 3.2 4.4)) 1))
  (assert-eq
   2 (linear-algebra-kernel::pivot-search-array
      #2A((1.1 1.4 1.3 1.2)
          (1.4 2.2 2.3 2.1)
          (1.3 2.3 3.3 3.2)
          (1.2 2.1 3.2 4.4)) 2))
  (assert-eq
   3 (linear-algebra-kernel::pivot-search-array
      #2A((1.1 1.4 1.3 1.2)
          (1.4 2.2 2.3 2.1)
          (1.3 2.3 3.3 3.2)
          (1.2 2.1 3.2 4.4)) 3))
  (assert-eq
   0 (linear-algebra-kernel::pivot-search-array
      #2A((2.2 1.1 1.1)
          (1.1 2.2 1.1)
          (1.1 1.1 2.2)) 0))
  (assert-eq
   1 (linear-algebra-kernel::pivot-search-array
      #2A((2.2 1.1 1.1)
          (1.1 2.2 1.1)
          (1.1 1.1 2.2)) 1))
  (assert-eq
   2 (linear-algebra-kernel::pivot-search-array
      #2A((2.2 1.1 1.1)
          (1.1 2.2 1.1)
          (1.1 1.1 2.2)) 2))
  (assert-eq
   2 (linear-algebra-kernel::pivot-search-array
      #2A((1.1 1.4  1.3 1.2)
          (1.4 2.2  2.3 2.1)
          (1.3 2.3 -3.3 3.2)
          (1.2 2.1  3.2 4.4)) 2)))

(define-test swap-rows-array
  (:tag :gauss)
  (assert-float-equal
   #2A((1.3 2.3 3.3 3.2)
       (1.4 2.2 2.3 2.1)
       (1.1 1.4 1.3 1.2)
       (1.2 2.1 3.2 4.4))
   (linear-algebra-kernel::swap-rows-array
    (make-array
     '(4 4) :initial-contents
     '((1.1 1.4 1.3 1.2)
       (1.4 2.2 2.3 2.1)
       (1.3 2.3 3.3 3.2)
       (1.2 2.1 3.2 4.4)))
    0 2)))

(define-test column-pivot-array
  (:tag :gauss)
  (let ((psv
         (linear-algebra-kernel::initialize-pivot-selection-vector 4))
        (array
         (make-array
          '(4 4) :initial-contents
          '((1.1 1.4 1.3 1.2)
            (1.4 2.2 2.3 2.1)
            (1.3 2.3 3.3 3.2)
            (1.2 2.1 3.2 4.4)))))
    ;;; Column 0
    (multiple-value-bind (array0 psv0)
        (linear-algebra-kernel::column-pivot-array
         array psv 0)
      (assert-eq array array0)
      (assert-eq psv psv0)
      (assert-rational-equal #(1 0 2 3) psv0)
      (assert-float-equal
       #2A((1.4 2.2 2.3 2.1)
           (0.7857143 -0.32857156 -0.507143 -0.44999993)
           (0.9285714  0.25714278 1.1642857  1.2500002)
           (0.8571429  0.21428538 1.2285714  2.6))
       array0))
    ;;; Column 1
    (multiple-value-bind (array1 psv1)
        (linear-algebra-kernel::column-pivot-array
         array psv 1)
      (assert-eq psv psv1)
      (assert-eq array array1)
      (assert-rational-equal #(1 0 2 3) psv1)
      (assert-float-equal
       #2A((1.4 2.2 2.3 2.1)
           (0.7857143 -0.32857156 -0.507143 -0.44999993)
           (0.9285714 -0.78260816  0.7673914 0.8978266)
           (0.8571429 -0.6521726   0.8978266 2.3065224))
       array1))
    ;;; Column 2
    (multiple-value-bind (array2 psv2)
        (linear-algebra-kernel::column-pivot-array
         array psv 2)
      (assert-eq psv psv2)
      (assert-eq array array2)
      (assert-rational-equal #(1 0 3 2) psv2)
      (assert-float-equal
       #2A((1.4 2.2 2.3 2.1)
           (0.7857143 -0.32857156 -0.507143  -0.44999993)
           (0.8571429 -0.6521726   0.8978266  2.3065224)
           (0.9285714 -0.78260816  0.8547211 -1.0736067))
       array2))))

(define-test factor-lr-array
  (:tag :gauss)
  (multiple-value-bind (array psv)
      (linear-algebra-kernel::factor-lr-array
       (make-array
        '(4 4) :initial-contents
        '((1.1 1.4 1.3 1.2)
          (1.4 2.2 2.3 2.1)
          (1.3 2.3 3.3 3.2)
          (1.2 2.1 3.2 4.4))))
    (assert-rational-equal #(1 0 3 2) psv)
    (assert-float-equal
     #2A((1.4        2.2         2.3        2.1)
         (0.7857143 -0.32857156 -0.507143  -0.44999993)
         (0.8571429 -0.6521726   0.8978266  2.3065224)
         (0.9285714 -0.78260816  0.8547211 -1.0736067))
     array)))