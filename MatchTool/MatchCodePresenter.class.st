"
Extended TextModel to allow special styling including the one for pattern nodes
"
Class {
	#name : #MatchCodePresenter,
	#superclass : #CodePresenter,
	#instVars : [
		'isForMatchHolder',
		'isForMethodHolder'
	],
	#category : #'MatchTool-ExtraSpec'
}

{ #category : #specs }
MatchCodePresenter class >> defaultSpec [
	<spec: #default>
	
	^ #(MatchTextAdapter
		adapt: #(model))
]

{ #category : #initialization }
MatchCodePresenter >> initialize [
	super initialize.
	isForMatchHolder := false asValueHolder.
	isForMethodHolder := false asValueHolder.
	isForMatchHolder
		whenChangedDo: [ :bool | self changed: #isForMatch: with: {bool} ].
	isForMethodHolder
		whenChangedDo: [ :bool | self changed: #isForMethod: with: {bool} ].
	self syntaxHighlight: true
]

{ #category : #setup }
MatchCodePresenter >> isForMatch [

	^ isForMatchHolder value
]

{ #category : #setup }
MatchCodePresenter >> isForMatch: aBoolean [

	isForMatchHolder value: aBoolean
]

{ #category : #setup }
MatchCodePresenter >> isForMethod [

	^ isForMethodHolder value
]

{ #category : #setup }
MatchCodePresenter >> isForMethod: aBoolean [

	isForMethodHolder value: aBoolean
]

{ #category : #events }
MatchCodePresenter >> whenEdited: aBlock [
	"Set a block to perform when the accept block changed"
	
	hasUnacceptedEdits whenChangedDo: [ :val |
		val ifTrue: aBlock value ]
]

{ #category : #events }
MatchCodePresenter >> whenIsForMatchChanged: aBlock [
	
	isForMatchHolder whenChangedDo: aBlock
]

{ #category : #events }
MatchCodePresenter >> whenIsForMethodChanged: aBlock [
	
	isForMethodHolder whenChangedDo: aBlock
]
