Class {
	#name : #MyRule2,
	#superclass : #RBTransformationRule,
	#category : #'MatchTool-RewriteTool-TestsData'
}

{ #category : #initialization }
MyRule2 >> initialize [
	super initialize.
	self rewriteRule
		replace:
			'true not
		ifTrue: [ ^ 1 + 1 ]
		ifFalse: [ ^ 1 + 0 ]'
		with: 'false
		ifTrue: [ ^ 1 + 1 ]
		ifFalse: [ ^ 1 + 0 ]'
				
]
