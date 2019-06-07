Extension { #name : #RBBlockNode }

{ #category : #'*MatchTool-RewriteTool' }
RBBlockNode >> optionsForNode [
	| options |
	options := super optionsForNode.
	options add: #('Abstract block' #abstractBlock).
	^ options
]
