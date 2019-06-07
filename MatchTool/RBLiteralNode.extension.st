Extension { #name : #RBLiteralNode }

{ #category : #'*MatchTool-RewriteTool' }
RBLiteralNode >> isInTemporariesList [
	^ false
]

{ #category : #'*MatchTool-RewriteTool' }
RBLiteralNode >> optionsForNode [
	| options |
	options := super optionsForNode.
	options
		add: #('Abstract literal' #abstractLiteral);
		add: #('Abstract object' #abstractMessage);
		yourself.
	^ options
]
