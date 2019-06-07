Extension { #name : #RBTransformationRule }

{ #category : #'*MatchTool-RewriteTool' }
RBTransformationRule >> input [
	^ String empty
]

{ #category : #'*MatchTool-RewriteTool' }
RBTransformationRule >> lhs [
	^ rewriteRule lhs formattedCode
]

{ #category : #'*MatchTool-RewriteTool' }
RBTransformationRule >> output [
	^ String empty
]

{ #category : #'*MatchTool-RewriteTool' }
RBTransformationRule >> rhs [
	^ rewriteRule rhs formattedCode
]
