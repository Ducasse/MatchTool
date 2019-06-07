Extension { #name : #RBSequenceNode }

{ #category : #'*MatchTool-RewriteTool' }
RBSequenceNode >> isInTemporariesList [
	^ true
]

{ #category : #'*MatchTool-RewriteTool' }
RBSequenceNode >> optionsForNode [
	| options |
	options := super optionsForNode.
	self temporaries isNotEmpty
		ifTrue: [ options add: #('Abstract temporaries list' #abstractTemporariesList) ].
	options add: #('Abstract statements' #abstractStatements).
	^ options
]
